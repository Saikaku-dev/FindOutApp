//
//  testGameView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/16.
//

import SwiftUI


struct item :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var foundCount:Int
}

class ItemManager:ObservableObject{
    @Published var items:[item] = [
        item(img: "street light", offset: CGSize(width: 50, height: 100),foundCount:0),
        item(img: "purple scarf", offset: CGSize(width: 150, height: 100),foundCount:0),
        item(img: "blue scarf", offset: CGSize(width: 250, height: 100),foundCount:0),
        item(img: "bus left", offset: CGSize(width: -200, height: 100),foundCount:0),
        item(img: "bus right", offset: CGSize(width: -300, height: 100),foundCount:0),
        item(img: "house", offset: CGSize(width: -50, height: 50),foundCount:0)
    ]
}

struct GameView: View {
    @State private var foundItems: Set<String> = [] // 存储已找到的item的imageName
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 1.5
    @GestureState private var dragScale: CGFloat = 1.0
    
    @State private var isStarted:Bool = true
    @State private var showFailedView:Bool = false
    @State private var found:Bool = false
    @State private var foundAllitems:Bool = false
    
    @State private var findCount:Int = 0
    @State private var totalCount:Int = 6
    @State private var countNumber:Int = 3
    @State private var successvViewOpacity:Double = 0
    
    @ObservedObject var itemdata = ItemCountData.shared
    @ObservedObject var itemManager = ItemManager()
    @ObservedObject var gameTime = GameTime.shared
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        GeometryReader { geometry in
            let imageSize = CGSize(width: geometry.size.width * defaultScale,
                                   height: geometry.size.height * defaultScale)
            let maxOffsetX = (imageSize.width - screenSize.width) / 2
            let maxOffsetY = (imageSize.height - screenSize.height) / 2
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ZStack {
                    Image("GameBackGround")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    //玩家需要找的元素
                    ForEach(itemManager.items.indices, id: \.self) { index in
                        let item = itemManager.items[index]
                        Button(action: {
                            shock()
                            itemManager.items[index].foundCount += 1
                            findCount += 1
                            foundItems.insert(item.img) // 将找到的item的imageName添加到集合中
                            
                            // 成功找到所有items或者时间归零
                            checkGameResult()
                        }) {
                            Image(item.img)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: ItemCountData.shared.imgSize,
                                       height:ItemCountData.shared.imgSize)
                        }
                        .offset(item.offset)
                        .disabled(foundItems.contains(item.img))
                    }
                }
                .scaledToFill()
                .scaleEffect(defaultScale * dragScale)
                .offset(x: limitedOffset(defaultOffset.width + dragOffset.width, max: maxOffsetX),
                        y: limitedOffset(defaultOffset.height + dragOffset.height, max: maxOffsetY))
                .gesture(
                    SimultaneousGesture (
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                defaultOffset.width = limitedOffset(defaultOffset.width + value.translation.width, max: maxOffsetX)
                                defaultOffset.height = limitedOffset(defaultOffset.height + value.translation.height, max: maxOffsetY)
                            },
                        MagnificationGesture()
                            .updating($dragScale) { value, scale, _ in
                                let newScale = defaultScale * value
                                if newScale < 1.0 {
                                    scale = 1.0 / defaultScale // 限制最小为1，但保持手势平滑
                                } else if newScale > 3.0 {
                                    scale = 3.0 / defaultScale // 限制最大为5，但保持手势平滑
                                } else {
                                    scale = value // 正常缩放
                                }
                            }
                            .onEnded { value in
                                defaultScale = min(max(defaultScale * value, 1.0), 3.0)
                            }
                    )
                )
                VStack {
                    GameTimeCountView()
                    Spacer()
                }
                .frame(height:UIScreen.main.bounds.height)
                .offset(y:-40)
                HStack {
                    ItemListView()
                        .environmentObject(itemManager)
                    Spacer()
                }
                .offset(y:-40)
                if isStarted {
                    if countNumber > 0 {
                        Text("\(countNumber)")
                            .font(.system(size:50))
                            .fontWeight(.bold)
                    } else {
                        Text("START！")
                            .font(.system(size:50))
                            .fontWeight(.bold)
                    }
                }
            }
            if foundAllitems && GameTime.shared.countTime > 0 {
                ConfettiView()
            }
            SuccessView()
                .opacity(successvViewOpacity)
        }
        .onAppear() {
            startGame()
        }
    }
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
    private func shock() {
        let shockOfFound = UINotificationFeedbackGenerator()
        shockOfFound.prepare()
        // 类型有 .success .error 和 .warning
        //分别对应通知,错误和警告
        shockOfFound.notificationOccurred(.warning)
    }
    
    
    private func countDownGauge() {
        if GameTime.shared.countTime >= 0 {
            gameTime.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                withAnimation (.linear(duration: 1)) {
                    GameTime.shared.countTime -= 1
                }
                checkGameResult()
            }
        } else {
            gameTime.countDownTimer?.invalidate()
        }
    }
    
    
    private func startGame() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { countTimer in
            if countNumber > 0 {
                countNumber -= 1
            } else if countNumber <= 0 {
                countTimer.invalidate()
                isStarted = false
                countNumber = 3
                countDownGauge()
            }
        }
    }
    private func showSuccessvView() {
        withAnimation(.linear(duration:1)) {
            successvViewOpacity += 1.0
            initinalData()
        }
    }
    private func checkGameResult() {
        if findCount == totalCount || GameTime.shared.countTime <= 0 {
            foundAllitems = true
            ItemCountData.shared.gameFinish = (findCount == totalCount)
            showSuccessvView()
        }
    }
    private func initinalData() {
        if successvViewOpacity == 1.0 {
            gameTime.countDownTimer?.invalidate()
            findCount = 0
            totalCount = 6
            foundAllitems = false
            GameTime.shared.countTime = 30
            ItemCountData.shared.gameFinish = false
        }
    }
}

#Preview {
    GameView()
}
