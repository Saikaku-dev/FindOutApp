import SwiftUI

struct item21: Identifiable {
    var id = UUID()
    var img: String
    var offset: CGSize
    var imgSize: CGFloat?
    var foundCount1: Int
}

class ItemManager21: ObservableObject {
    @Published var items: [item21] = [
        item21(img: "yellowKid01", offset: CGSize(width: -270, height: -118), imgSize: 4, foundCount1: 0),//窗户上无头黄色女孩 👌
        item21(img: "yellowKid02", offset: CGSize(width: -175, height: -123), imgSize: 6, foundCount1: 0)//阳台上完整黄色女孩👌
    ]
}

struct item22: Identifiable {
    var id = UUID()
    var img: String
    var offset: CGSize
    var imgSize: CGFloat?
    var foundCount2: Int
}

class ItemManager22: ObservableObject {
    @Published var items: [item22] = [
        item22(img: "blackKid01", offset: CGSize(width: 210, height: 47), imgSize: 6, foundCount2: 0),  //右侧半截小男孩 👌
        item22(img: "blackKid02", offset: CGSize(width: -249, height: -95), imgSize: 5, foundCount2: 0),  // 桌边小男孩 👌
        item22(img: "blackKid03", offset: CGSize(width: -112 ,height: -95), imgSize: 6, foundCount2: 0), //滑梯小男孩
        item22(img: "blackKid04", offset: CGSize(width: 200, height: -138), imgSize: 6, foundCount2: 0)// 楼顶小男孩 👌
    ]
}

struct item23: Identifiable {
    var id = UUID()
    var img: String
    var offset: CGSize
    var imgSize: CGFloat?
    var foundCount3: Int
}

class ItemManager23: ObservableObject {
    @Published var items: [item23] = [
        item23(img: "brownKid01", offset: CGSize(width: -19, height: -128), imgSize: 8, foundCount3: 0),  //上方正窗小女孩 👌
        item23(img: "brownKid02", offset: CGSize(width: -9, height: 50), imgSize: 9, foundCount3: 0),//正门小女孩👌
        item23(img: "brownKid03", offset: CGSize(width: 200, height: 120), imgSize: 15, foundCount3: 0),   //空地小女孩 👌
        item23(img: "brownKid04", offset: CGSize(width: 315, height: 133), imgSize: 7
               , foundCount3: 0)  //只有头小女孩 👌
    ]
}

//第二张三个物品图道具栏
struct item2z :Identifiable{
   var id = UUID()
   var img:String
//    var foundCount:Int
}
//地图按钮的类
class ItemManager2z:ObservableObject{
   @Published var items:[item2z] = [
       item2z(img: "yellowKid02"),
       item2z(img: "blackKid04"),
       item2z(img: "brownKid03")
   ]
}


import SwiftUI
import AVFoundation

struct KindergartenTest: View {
    @ObservedObject var audioManager = AudioManager.shared
    @State private var foundItems: Set<String> = []
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0

    @State private var isStarted: Bool = true
    @State private var foundAllItems: Bool = false
    @State private var touchObject: Bool = true

    // Separate counts for each item type
    @State private var findCount: Int = 0  // 确保声明 findCount
    @State private var foundCount1: Int = 0 // Yellow items count
    @State private var foundCount2: Int = 0 // Black items count
    @State private var foundCount3: Int = 0 // Brown items count
    @State private var totalCount: Int = 10
    @State private var countNumber: Int = 3

    @State private var showSuccessView: Bool = false
    @State private var showFailedView: Bool = false
    @State private var shouldShowGameView: Bool = true

    @ObservedObject var itemManager21 = ItemManager21()
    @ObservedObject var itemManager22 = ItemManager22()
    @ObservedObject var itemManager23 = ItemManager23()
    @ObservedObject var gameTime = GameTime.shared
    
    let screenSize = UIScreen.main.bounds.size
    let maxScale: CGFloat = 3.0
    let minScale: CGFloat = 1.0

    var body: some View {
        if shouldShowGameView {
            GeometryReader { geometry in
                let imageSize = CGSize(width: geometry.size.width * defaultScale, height: geometry.size.height * defaultScale)
                let maxOffsetX = (imageSize.width - screenSize.width) / 2
                let maxOffsetY = (imageSize.height - screenSize.height) / 2

                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)

                    ZStack {
                        Image("basicKingdergartenMap")
                            .resizable()
                            .aspectRatio(contentMode: .fill)

                        // Yellow items
                        ForEach(itemManager21.items.indices, id: \.self) { index in
                            let item21 = itemManager21.items[index]
                            Button(action: {
                                shock()
                                itemManager21.items[index].foundCount1 += 1
                                foundCount1 += 1
                                foundItems.insert(item21.img)
                                checkGameResult()
                            }) {
                                Image(item21.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: item21.imgSize ?? 20)
                            }
                            .opacity(foundItems.contains(item21.img) ? 0 : 1)
                            .offset(item21.offset)
                            .disabled(foundItems.contains(item21.img))
                            .disabled(touchObject)
                        }

                        // Black items
                        ForEach(itemManager22.items.indices, id: \.self) { index in
                            let item22 = itemManager22.items[index]
                            Button(action: {
                                shock()
                                itemManager22.items[index].foundCount2 += 1
                                foundCount2 += 1
                                foundItems.insert(item22.img)
                                checkGameResult()
                            }) {
                                Image(item22.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: item22.imgSize ?? 20)
                            }
                            .opacity(foundItems.contains(item22.img) ? 0 : 1)
                            .offset(item22.offset)
                            .disabled(foundItems.contains(item22.img))
                            .disabled(touchObject)
                        }

                        // Brown items
                        ForEach(itemManager23.items.indices, id: \.self) { index in
                            let item23 = itemManager23.items[index]
                            Button(action: {
                                shock()
                                itemManager23.items[index].foundCount3 += 1
                                foundCount3 += 1
                                foundItems.insert(item23.img)
                                checkGameResult()
                            }) {
                                Image(item23.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: item23.imgSize ?? 20)
                            }
                            .opacity(foundItems.contains(item23.img) ? 0 : 1)
                            .offset(item23.offset)
                            .disabled(foundItems.contains(item23.img))
                            .disabled(touchObject)
                        }
                    }
                    .scaleEffect(min(max(defaultScale * gestureScale, minScale), maxScale))
                    .offset(x: limitedOffset(defaultOffset.width + dragOffset.width, max: maxOffsetX),
                            y: limitedOffset(defaultOffset.height + dragOffset.height, max: maxOffsetY))
                    .gesture(
                        SimultaneousGesture(
                            DragGesture()
                                .updating($dragOffset) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    defaultOffset.width = limitedOffset(defaultOffset.width + value.translation.width, max: maxOffsetX)
                                    defaultOffset.height = limitedOffset(defaultOffset.height + value.translation.height, max: maxOffsetY)
                                },
                            MagnificationGesture()
                                .updating($gestureScale) { value, state, _ in
                                    state = min(max(value, minScale / defaultScale), maxScale / defaultScale)
                                }
                                .onEnded { value in
                                    defaultScale = min(max(defaultScale * value, minScale), maxScale)
                                }
                        )
                    )

                    VStack {
                        GameTimeCountView()
                        Spacer()
                    }
                    .frame(height: UIScreen.main.bounds.height)

                    HStack {
                        ItemListView2z(
                            foundCounty: $foundCount1,
                            foundCountb: $foundCount2,
                            foundCountg: $foundCount3
                        )
                        Spacer()
                    }

                    if isStarted {
                        if countNumber > 0 {
                            Text("\(countNumber)")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                        } else {
                            Text("START！")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .onAppear {
                audioManager.playBackgroundMusic(for: 2)
                startGame()
            }
            .onDisappear {
                audioManager.stopMusic()
            }
            .fullScreenCover(isPresented: $showSuccessView) {
                SuccessView(onReturnHome: {
                    resetGame()
                    shouldShowGameView = false
                })
                .onAppear {
                    audioManager.stopMusic()
                }
            }
            .fullScreenCover(isPresented: $showFailedView) {
                FailedView(onReturnHome: {
                    resetGame()
                    shouldShowGameView = false
                })
                .onAppear {
                    audioManager.stopMusic()
                }
            }
        } else {
            HomeView()
        }
    }

    private func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
    
    private func shock() {
        let shockOfFound = UINotificationFeedbackGenerator()
        shockOfFound.prepare()
        shockOfFound.notificationOccurred(.warning)
    }

    private func countDownGauge() {
        gameTime.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(.linear(duration: 1)) {
                GameTime.shared.countTime -= 1
            }
            checkGameResult()
        }
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
    
    private func checkGameResult() {
        let totalFoundItems = foundCount1 + foundCount2 + foundCount3
        findCount = totalFoundItems
        if findCount == totalCount {
            gameTime.countDownTimer?.invalidate()
            showSuccessView = true
            foundAllItems = true
        } else if GameTime.shared.countTime <= 0 {
            gameTime.countDownTimer?.invalidate()
            showFailedView = true
            foundAllItems = true
        }
    }
    
    private func resetGame() {
        
        gameTime.countDownTimer?.invalidate()
        findCount = 0
        totalCount = 10
        foundAllItems = false
        GameTime.shared.countTime = 60
        touchObject = true
        isStarted = true
        showSuccessView = false
        showFailedView = false
        foundItems.removeAll()
        foundCount1 = 0
        foundCount2 = 0
        foundCount3 = 0
    }
}

#Preview {
    KindergartenTest()
}
