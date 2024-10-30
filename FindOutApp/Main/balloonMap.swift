//
//  balloonMap.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/31.
//


//  balloonMap.swift


import SwiftUI


struct balloons: Identifiable {
    var id = UUID()
    var img: String
    var offset: CGSize
    var foundCount: Int
}

class BalloonManager: ObservableObject {
    @Published var items: [balloons] = [
        balloons(img: "balloon1", offset: CGSize(width: 50, height: -100), foundCount: 0),
        balloons(img: "balloon2", offset: CGSize(width: 150, height: -100), foundCount: 0),
        balloons(img: "balloon3", offset: CGSize(width: 250, height: -100), foundCount: 0),
        balloons(img: "balloon4", offset: CGSize(width: -200, height: -100), foundCount: 0),
        balloons(img: "balloon5", offset: CGSize(width: -300, height: -200), foundCount: 0),
        balloons(img: "balloon6", offset: CGSize(width: -50, height: -150), foundCount: 0),
        balloons(img: "balloon7", offset: CGSize(width: -50, height: -250), foundCount: 0),
        balloons(img: "balloon8", offset: CGSize(width: -50, height: -200), foundCount: 0),
        balloons(img: "balloon9", offset: CGSize(width: -50, height: -180), foundCount: 0),
        balloons(img: "balloon10", offset: CGSize(width: -50, height: -50), foundCount: 0)
    ]
}

struct balloonMap: View {

        @State var count : Double=0.0 //更新进度条
                        //获取动画发生位置坐标
//        @State private var Position:CGPoint = CGPoint(x:0,y:0)
        @State private var findCount:Int = 0//已经找到的数量

        //计算偏移量用来计算移动后的当前画面
        @State private var defaultOffset: CGSize = .zero
        @GestureState private var dragOffset: CGSize = .zero
                        //缩放比例
        @State private var defaultScale: CGFloat = 1.0
        @GestureState private var dragScale: CGFloat = 1.0
                        //itemBarSize
        @State private var itemBarOpacity:CGFloat = 1.0
    //    @State var itemBarButton = false
        @State private var isStarted:Bool = true//游戏开始倒计时
        @State private var countNumber:Int = 3//游戏开始倒计时长度3秒
        
        @State private var totalCount: Int = 10

        @State private var showSuccessView: Bool = false
        @State private var showFailedView: Bool = false
        @State private var foundAllitems: Bool = false
        
        @State private var shouldShowBalloonView: Bool = true  // 控制是否显示balloonMapView

        @State private var foundItems: Set<String> = [] // 存储已找到的item的imageName
//    @ObservedObject var itemManager = ItemManager()

    @ObservedObject var balloonManager = BalloonManager()

//        @ObservedObject var itemdata2z = ItemCountData.shared
//        @ObservedObject var itemManager2z = ItemManager2z()
//        @ObservedObject var itemManager21 = ItemManager21()
//        @ObservedObject var itemManager22 = ItemManager22()
//        @ObservedObject var itemManager23 = ItemManager23()
        
        @ObservedObject var gameTime = GameTime.shared
        @State private var touchObject: Bool = true


        let screenSize = UIScreen.main.bounds.size


        var body: some View {
            if shouldShowBalloonView {
                
                GeometryReader { geometry in
                    let imageSize = CGSize(width: geometry.size.width * defaultScale, height: geometry.size.height * defaultScale)
                    let maxOffsetX = (imageSize.width - screenSize.width) / 2
                    let maxOffsetY = (imageSize.height - screenSize.height) / 2
                
                    
                    ZStack{
                        Image("balloonMap")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                        
                        //玩家需要找的元素
                        ForEach(balloonManager.items.indices, id: \.self) { index in
                            let itemb = balloonManager.items[index]
                            Button(action: {
                                findCount += 1
                                balloonManager.items[index].foundCount += 1
                                foundItems.insert(itemb.img)
                            }) {
                                Image(itemb.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(foundItems.contains(itemb.img) ? 0:1)
                                    .frame(width: ItemCountData.shared.imgSize,
                                           height:ItemCountData.shared.imgSize)
                            }
                            .offset(itemb.offset)
                            //                    .disabled(foundItems.contains(item.img))
                        }
                        

                        
                    }//ZStack end
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
                    )//gesture end
                    
                    //时间进度条
                    VStack {
                        GameTimeCountView()
                        Spacer()
                    }
                    .frame(height:UIScreen.main.bounds.height)
                    .offset(y:40)
                    //道具栏
                    HStack {
                        balloonListView()  // 确保 item 列表显示
                            .environmentObject(balloonManager)
                        Spacer()
                    }
                    .offset(y: -30)
                    //                    .offset(x:-350,y:0)
//                    .offset(y:150)
                    
                    //游戏开始倒计时
                    if isStarted {
                        //开始倒计时
                        if countNumber > 0 {
                            Text("\(countNumber)")
                                .font(.system(size:50))
                                .fontWeight(.bold)
                        } else {
                            Text("START！")
                                .font(.system(size:50))
                                .fontWeight(.bold)
                        }
                    }//if isStarted end
                    
                }//GeometryReader end
                
                .onAppear {
                    startGame()
                }
                
                .fullScreenCover(isPresented: $showSuccessView) {
                    SuccessView(onReturnHome: {
                        resetGame()
                        shouldShowBalloonView = false
                    })
                }
                .fullScreenCover(isPresented: $showFailedView) {
                    FailedView(onReturnHome: {
                        resetGame()
                        shouldShowBalloonView = false
                    })
                }
            }
            else {
                HomeView() // 控制从 HomeView 返回 GameView
            }

        }//var body end
        
        private func startGame() {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { countTimer in
                if countNumber > 0 {
                    countNumber -= 1
                } else {
                    countTimer.invalidate()
                    isStarted = false
                    touchObject = false
                    countDownGauge()
                }
            }
        }
        
        private func countDownGauge() {
        gameTime.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(.linear(duration: 1)) {
                GameTime.shared.countTime -= 1
            }
            checkGameResult()
        }
    }
        
        private func checkGameResult() {
            if findCount == totalCount {
                gameTime.countDownTimer?.invalidate()
                showSuccessView = true
                foundAllitems = true
            } else if GameTime.shared.countTime <= 0 {
                gameTime.countDownTimer?.invalidate()
                showFailedView = true
                foundAllitems = true
            }
        }
        
        private func resetGame() {
            gameTime.countDownTimer?.invalidate()
            findCount = 0
            totalCount = 6
            foundAllitems = false
            GameTime.shared.countTime = 30
            touchObject = true
            isStarted = true
            showSuccessView = false
            showFailedView = false
        }
        
        func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
            return max(min(offset, limit), -limit)
        }
        

    #Preview {
        kindergertenTest()
    }


    
}

#Preview {
    balloonMap()
}
