//
//  kindergertenTest.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/29.
//

import SwiftUI

struct item21 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var imgSize: CGFloat?
    var foundCount1:Int
}
//地图按钮的类黄色
class ItemManager21:ObservableObject{
    @Published var items:[item21] = [
        item21(img: "yellowKid01", offset: CGSize(width: -280, height: -125),imgSize: 20,foundCount1:0),
        item21(img: "yellowKid02", offset: CGSize(width: -180, height: -130),imgSize: 20,foundCount1:0)
    ]
}


struct item22 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var imgSize: CGFloat?
    var foundCount2:Int
}
//地图按钮的类黑色
class ItemManager22:ObservableObject{
    @Published var items:[item22] = [
        item22(img: "blackKid01", offset: CGSize(width: 220, height: -150),imgSize: 15,foundCount2:0),
        item22(img: "blackKid02", offset: CGSize(width: -200, height: -180),imgSize: 15,foundCount2:0),
        item22(img: "blackKid03", offset: CGSize(width: -80, height: -140),imgSize: 15,foundCount2:0),
        item22(img: "blackKid04", offset: CGSize(width: -50, height: -180),imgSize: 15,foundCount2:0)
    ]
}

struct item23 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var imgSize: CGFloat?
    var foundCount3:Int
}
//地图按钮的类棕色
class ItemManager23:ObservableObject{
    @Published var items:[item23] = [
        item23(img: "brownKid01", offset: CGSize(width: 10, height: -10),imgSize: 15,foundCount3:0),
        item23(img: "brownKid02", offset: CGSize(width: -20, height: -100),imgSize: 15,foundCount3:0),
        item23(img: "brownKid03", offset: CGSize(width: -80, height: -60),imgSize: 15,foundCount3:0),
        item23(img: "brownKid04", offset: CGSize(width: -110, height: -130),imgSize: 15,foundCount3:0)
    ]
}

//第二张三个物品图道具栏
struct item2z :Identifiable{
    var id = UUID()
    var img:String
//    var foundCount:Int
}
//道具栏的类
class ItemManager2z:ObservableObject{
    @Published var items:[item2z] = [
        item2z(img: "yellowKid02"),
        item2z(img: "blackKid04"),
        item2z(img: "brownKid03")
    ]
}

struct kindergertenTest: View {

    @State var count : Double=0.0 //更新进度条
                    //获取动画发生位置坐标
    @State private var Position:CGPoint = CGPoint(x:0,y:0)
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

    @State private var foundCount1:Int = 0
    @State private var foundCount2:Int = 0
    @State private var foundCount3:Int = 0


    @State private var showSuccessView: Bool = false
    @State private var showFailedView: Bool = false
    @State private var foundAllitems: Bool = false
    
    @State private var shouldShowKindergartenView: Bool = true  // 控制是否显示KindergartenView


    
    @State private var foundItems: Set<String> = [] // 存储已找到的item的imageName
    
    @ObservedObject var itemdata2z = ItemCountData.shared
    @ObservedObject var itemManager2z = ItemManager2z()
    @ObservedObject var itemManager21 = ItemManager21()
    @ObservedObject var itemManager22 = ItemManager22()
    @ObservedObject var itemManager23 = ItemManager23()
    
    @ObservedObject var gameTime = GameTime.shared
    @State private var touchObject: Bool = true


    let screenSize = UIScreen.main.bounds.size


    var body: some View {
        if shouldShowKindergartenView {
            
            GeometryReader {  geometry in
                let imageSize = CGSize(width: geometry.size.width * defaultScale,height: geometry.size.height * defaultScale)
                let maxOffsetX = (imageSize.width - screenSize.width) / 2
                let maxOffsetY = (imageSize.height - screenSize.height) / 2

                ZStack{
                        Image("allKingdergartenMap")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                        
                        //玩家需要找的元素黄色2
                        ForEach(itemManager21.items.indices, id: \.self) { index in
                            let item21 = itemManager21.items[index]
                            Button(action: {
                                foundCount1 += 1
                                findCount += 1
                                checkGameResult()
                                //bool型 =true
                            }) {
                                Image(item21.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(foundItems.contains(item21.img) ? 0 : 1)
//                                    .frame(width: (item21.imgSize ?? 20) * defaultScale) // 缩放大小
                                    .frame(width: item21.imgSize)
                            }
                            .offset(item21.offset)
                            .offset(
                                    x: (item21.offset.width * defaultScale) + defaultOffset.width + dragOffset.width,
                                    y: (item21.offset.height * defaultScale) + defaultOffset.height + dragOffset.height
                                ) // 动态偏移
                            .disabled(foundItems.contains(item21.img))
                            .disabled(touchObject)
                        }
                        
                        //玩家需要找的元素黑色4
                        ForEach(itemManager22.items.indices, id: \.self) { index in
                            let item22 = itemManager22.items[index]
                            Button(action: {
                                foundCount2 += 1
                                findCount += 1
                                checkGameResult()
                            }) {
                                Image(item22.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
//                                    .opacity(foundItems.contains(item22.img) ?
//                                             0:1)
//                                    .frame(width: (item22.imgSize ?? 20) * defaultScale) // 缩放大小
                                    .frame(width: item22.imgSize)
                                
                            }
                            .offset(
                                    x: (item22.offset.width * defaultScale) + defaultOffset.width + dragOffset.width,
                                    y: (item22.offset.height * defaultScale) + defaultOffset.height + dragOffset.height
                                ) // 动态偏移
                            
                            .offset(item22.offset)
                            .disabled(foundItems.contains(item22.img))
                            .disabled(touchObject)
                        }
                        
                        //玩家需要找的元素棕色4
                        ForEach(itemManager23.items.indices, id: \.self) { index in
                            let item23 = itemManager23.items[index]
                            Button(action: {
                                //                        itemManager23.items[index].
                                foundCount3 += 1
                                findCount += 1
                                checkGameResult()
                            }) {
                                Image(item23.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
//                                    .opacity(foundItems.contains(item23.img) ? 0:1)
//                                    .frame(width: (item23.imgSize ?? 20) * defaultScale) // 缩放大小
                                                                .frame(width: item23.imgSize)
                                
//                                    .frame(width: ItemCountData.shared.imgSize,
//                                           height:ItemCountData.shared.imgSize)
                            }
                            .offset(
                                    x: (item23.offset.width * defaultScale) + defaultOffset.width + dragOffset.width,
                                    y: (item23.offset.height * defaultScale) + defaultOffset.height + dragOffset.height
                                ) // 动态偏移
                            .offset(item23.offset)
                            .disabled(touchObject)
                            .disabled(foundItems.contains(item23.img))
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
                                scale = (newScale < 1.0) ? 1.0 / defaultScale : min(3.0 / defaultScale, value)
                            }
                            .onEnded { value in
                                defaultScale = min(max(defaultScale * value, 1.0), 3.0)
                            }
                    )
                )
                    //时间进度条
                    VStack {
                        GameTimeCountView()
                        Spacer()
                    }
                    .frame(height:UIScreen.main.bounds.height)
//                    .offset(y:40)
                    //道具栏
                    HStack {
                        ItemListView2z(foundCounty: $foundCount1,foundCountb: $foundCount2,foundCountg:$foundCount3)
                            .environmentObject(itemManager2z)
                        Spacer()
                    }
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
                    shouldShowKindergartenView = false
                })
            }
            .fullScreenCover(isPresented: $showFailedView) {
                FailedView(onReturnHome: {
                    resetGame()
                    shouldShowKindergartenView = false
                })
            }
        }//if end
        else {
            HomeView() // 控制从 HomeView 返回 GameView
        }

    }//var body end
    
    private func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
    
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
    
//    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
//        return max(min(offset, limit), -limit)
//    }
    
    
}

#Preview {
    kindergertenTest()
}
