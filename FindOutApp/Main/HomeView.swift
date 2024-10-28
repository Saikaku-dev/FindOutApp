import SwiftUI

struct HomeView: View {
    @State private var showCloudView = false // 控制 CloudView 显示状态
    @State private var showGameView = false // 控制 GameView 显示状态
    @State private var showSettingView: Bool = false // 控制 SettingView 显示状态
    
    // 默认没有锁定关卡
    @State private var lockedLevels = [Int]() // 解锁所有关卡

    var body: some View {
        ZStack {
            if showGameView {
                GameView() // GameView 显示
                    .transition(.opacity) // 使用 opacity 动画
            } else if showCloudView {
                CloudView(isOpening: $showCloudView, showGameView: $showGameView) // CloudView 显示
                    .transition(.opacity) // 使用 opacity 动画
            } else {
                VStack {
                    // 顶部的设置和金币栏
                    HStack {
                        Spacer()
                        Button(action: {
                            showSettingView = true // 点击设置按钮时显示 SettingView
                        }) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    Text("地図を選びください！")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .foregroundColor(.blue)

                    // 使用 ScrollView 水平滚动的方式显示关卡
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            // 第一关卡
                            ZStack {
                                Image("level1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)

                                 
                                    VStack {
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.easeInOut(duration: 1.0)) {
                                                showCloudView = true // 显示 CloudView
                                            }
                                        }) {
                                            HStack {
                                                Image(systemName: "play.fill")
                                                    .foregroundColor(.black)
                                                Text("開始")
                                                    .foregroundColor(.black)
                                                    .font(.headline.weight(.bold))
                                            }
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(Color.green)
                                            .cornerRadius(20)
                                        }
                                        .padding(.bottom, 20)
                                        
                                    }
                                
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
                .sheet(isPresented: $showSettingView) {
                    SettingView() // 显示 SettingView 作为 Sheet
                }
            }
        }
        .animation(.easeInOut(duration: 2.0), value: showCloudView) // 控制 CloudView 过渡动画
        .animation(.easeInOut(duration: 1.0), value: showGameView) // 控制 GameView 过渡动画
    }
}

#Preview {
    HomeView()
}
