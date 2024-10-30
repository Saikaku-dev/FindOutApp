//
//  testGameView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/16.
//

import SwiftUI
import AVFoundation

struct item: Identifiable {
    var id = UUID()
    var img: String
    var offset: CGSize
    var foundCount: Int
}

class ItemManager: ObservableObject {
    @Published var items: [item] = [
        item(img: "street light", offset: CGSize(width: 50, height: 100), foundCount: 0),
        item(img: "purple scarf", offset: CGSize(width: 150, height: 100), foundCount: 0),
        item(img: "blue scarf", offset: CGSize(width: 250, height: 100), foundCount: 0),
        item(img: "bus left", offset: CGSize(width: -200, height: 100), foundCount: 0),
        item(img: "bus right", offset: CGSize(width: -300, height: 100), foundCount: 0),
        item(img: "house", offset: CGSize(width: -50, height: 50), foundCount: 0)
    ]
}

import SwiftUI
import AVFoundation

struct GameView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var foundItems: Set<String> = []
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 1.5
    @GestureState private var dragScale: CGFloat = 1.0
    
    @State private var isStarted: Bool = true
    @State private var foundAllitems: Bool = false
    @State private var touchObject: Bool = true
    
    @State private var findCount: Int = 0
    @State private var totalCount: Int = 6
    @State private var countNumber: Int = 3
    
    @State private var showSuccessView: Bool = false
    @State private var showFailedView: Bool = false
    @State private var shouldShowGameView: Bool = true  // 控制是否显示GameView
    
    @ObservedObject var itemManager = ItemManager()
    @ObservedObject var gameTime = GameTime.shared
    
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        if shouldShowGameView {
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
                        ForEach(itemManager.items.indices, id: \.self) { index in
                            let item = itemManager.items[index]
                            Button(action: {
                                shock()
                                findCount += 1
                                itemManager.items[index].foundCount += 1
                                foundItems.insert(item.img)
                                checkGameResult()
                            }) {
                                Image(item.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .offset(item.offset)
                            .disabled(foundItems.contains(item.img))
                            .disabled(touchObject)
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
                    )//gesture end
                    
                    VStack {
                        GameTimeCountView()  // 确保倒计时显示
                        Spacer()
                    }
                    .frame(height: UIScreen.main.bounds.height)
                    .offset(y: 20)
                    
                    HStack {
                        ItemListView()  // 确保 item 列表显示
                            .environmentObject(itemManager)
                        Spacer()
                    }
                    .offset(y: -30)
                    
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
                    
                }//ZStack end
            }//GeometryReader end
            
            .onAppear {
                startGame()
            }
            .fullScreenCover(isPresented: $showSuccessView) {
                SuccessView(onReturnHome: {
                    resetGame()
                    shouldShowGameView = false
                })
            }
            .fullScreenCover(isPresented: $showFailedView) {
                FailedView(onReturnHome: {
                    resetGame()
                    shouldShowGameView = false
                })
            }
        }
        else {
            HomeView() // 控制从 HomeView 返回 GameView
        }
    }//var body end
    
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
    
}//struct GameView end

#Preview{
    GameView()
}
