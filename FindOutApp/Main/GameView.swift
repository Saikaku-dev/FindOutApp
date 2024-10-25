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
    var findedCount:Int
}

class ItemManager:ObservableObject{
    @Published var items:[item] = [
        item(img: "street light", offset: CGSize(width: 50, height: 100),findedCount:0),
        item(img: "purple scarf", offset: CGSize(width: 150, height: 100),findedCount:0),
        item(img: "blue scarf", offset: CGSize(width: 250, height: 100),findedCount:0),
        item(img: "bus left", offset: CGSize(width: -200, height: 100),findedCount:0),
        item(img: "bus right", offset: CGSize(width: -300, height: 100),findedCount:0),
        item(img: "house", offset: CGSize(width: -50, height: 50),findedCount:0)
    ]
}

struct GameView: View {
    @State private var foundItems: Set<String> = [] // 存储已找到的item的imageName
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 1.5
    @GestureState private var dragScale: CGFloat = 1.0
    @ObservedObject var itemdata = ItemCountData.shared
    @ObservedObject var itemManager = ItemManager()
    @State private var found:Bool = false
    let screenSize = UIScreen.main.bounds.size
    @State private var findCount:Int = 0
    @State private var totalCount:Int = 6
    @State private var countTimer:Timer?
    @State private var countNumber: Int = 3
    @State private var showCount:Bool = false
    @State private var textChange:Bool = false
    @State private var gaugeValue:Double = 1
    @State private var gameFinish:Bool = false
    @State private var showFailedOpacity:Double = 0
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
                            itemManager.items[index].findedCount += 1
                            findCount += 1
                            foundItems.insert(item.img) // 将找到的item的imageName添加到集合中
                            
                            // 游戏结束
                            if findCount == totalCount {
                                
                            }
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
                HStack {
                    ItemListView()
                        .environmentObject(itemManager)
                        .onTapGesture {
                            //
                        }
                    Spacer()
                }
                if showCount {
                    
                    Text(textChange ? "Start" : "\(countNumber)")
                        .font(.system(size:150))
                        .fontWeight(.bold)
                }
            }
        }
        .onAppear() {
            //開始
            showCount = true
            startCount()
        }
        if gameFinish {
            FailedView()
                .opacity(showFailedOpacity)
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
    private func startCount() {
        countTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countNumber > 1 {
                countNumber -= 1
            } else if countNumber <= 1 {
                countTimer?.invalidate()
                textChange = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showCount = false
                    countDownStart()
                }
            }
        }
    }
    private func gaugeChange() -> Color {
        if gaugeValue == 1.0 {
        }
        
        return Color.blue
    }
    private func countDownStart() {
        if GameTime.shared.countTime > 0 {
            GameTime.shared.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                withAnimation (.linear(duration: 1)) {
                    GameTime.shared.countTime -= 1
                }
                GameTime.shared.stopCountDownTimer()
                countDownStop()
            }
        } else {
            GameTime.shared.countDownTimer?.invalidate()
        }
    }
    private func countDownStop() {
        if GameTime.shared.countTime <= 0 {
            GameTime.shared.countDownTimer?.invalidate()
            gameFinish = true
            showFailedView()
        }
    }
    private func showFailedView() {
        withAnimation(.linear(duration: 1)) {
            showFailedOpacity += 1
        }
    }
}

#Preview {
    GameView()
}
