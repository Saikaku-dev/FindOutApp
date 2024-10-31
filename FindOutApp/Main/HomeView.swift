//import SwiftUI
//
//struct HomeView: View {
//    @State private var showCloudView = false // 控制 CloudView 显示状态
//    @State private var showGameView = false // 控制 GameView 显示状态
//    @State private var showKindergartenView = false // 控制 KindergartenView 显示状态
//    @State private var showSettingView: Bool = false // 控制 SettingView 显示状态
//    @State private var selectedLevel: Int? = nil //  用于记录选择的关卡
//
//    var body: some View {
//        ZStack {
//            if showGameView {
//                GameView()
//                    .transition(.opacity)
//            } else if showKindergartenView {
//                kindergertenTest()
//                    .transition(.opacity)
//            } else if showCloudView {
//                CloudView(isOpening: $showCloudView, showGameView: $showGameView, showKindergartenView: $showKindergartenView, selectedLevel: $selectedLevel)
//                    .transition(.opacity)
//            } else {
//                VStack {
//                    HStack {
//                        Spacer()
//                        Button(action: { showSettingView = true }) {
//                            Image(systemName: "gearshape.fill")
//                                .resizable()
//                                .frame(width: 25, height: 25)
//                                .foregroundColor(.black)
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.top, 20)
//
//                    Text("地図を選びください！")
//                        .fontWeight(.bold)
//                        .font(.system(size: 30))
//                        .foregroundColor(.blue)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHStack(spacing: 20) {
//                            // 第一关按钮
//                            ZStack {
//                                Image("level1")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(height: 200)
//                                    .cornerRadius(20)
//                                    .shadow(radius: 5)
//                                VStack {
//                                    Spacer()
//                                    Button(action: {
//                                        withAnimation(.easeInOut(duration: 1.0)) {
//                                            selectedLevel = 1 // 👈 选择第一关
//                                            showCloudView = true
//                                            showGameView = false
//                                            showKindergartenView = false
//                                        }
//                                    }) {
//                                        HStack {
//                                            Image(systemName: "play.fill")
//                                                .foregroundColor(.black)
//                                            Text("開始")
//                                                .foregroundColor(.black)
//                                                .font(.headline.weight(.bold))
//                                        }
//                                        .padding(.horizontal, 20)
//                                        .padding(.vertical, 10)
//                                        .background(Color.green)
//                                        .cornerRadius(20)
//                                    }
//                                    .padding(.bottom, 20)
//                                }
//                            }
//
//                            // 第二关按钮
//                            ZStack {
//                                Image("level2")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(height: 200)
//                                    .cornerRadius(20)
//                                    .shadow(radius: 5)
//                                VStack {
//                                    Spacer()
//                                    Button(action: {
//                                        withAnimation(.easeInOut(duration: 1.0)) {
//                                            selectedLevel = 2 // 👈 选择第二关
//                                            showCloudView = true
//                                            showGameView = false
//                                            showKindergartenView = false
//                                        }
//                                    }) {
//                                        HStack {
//                                            Image(systemName: "play.fill")
//                                                .foregroundColor(.black)
//                                            Text("開始")
//                                                .foregroundColor(.black)
//                                                .font(.headline.weight(.bold))
//                                        }
//                                        .padding(.horizontal, 20)
//                                        .padding(.vertical, 10)
//                                        .background(Color.green)
//                                        .cornerRadius(20)
//                                    }
//                                    .padding(.bottom, 20)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                    
//                    Spacer()
//                }
//                .sheet(isPresented: $showSettingView) {
//                    SettingView()
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    HomeView()
//}



import SwiftUI

struct HomeView: View {
    @State private var showCloudLoadingView = false
    @State private var selectedLevel: Int? = nil
    @State private var showGameView = false
    @State private var showKindergartenView = false

    var body: some View {
        ZStack {
            if showGameView {
                GameView()
                    .transition(.opacity)
            } else if showKindergartenView {
                kindergertenTest()
                    .transition(.opacity)
            } else if showCloudLoadingView {
                CloudLoadingView(
                    showCloudLoadingView: $showCloudLoadingView,
                    selectedLevel: $selectedLevel,
                    showGameView: $showGameView,
                    showKindergartenView: $showKindergartenView
                )
                .transition(.opacity)
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { /* 设置按钮操作 */ }) {
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

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            LevelButton(level: 1, showCloudLoadingView: $showCloudLoadingView, selectedLevel: $selectedLevel)
                            LevelButton(level: 2, showCloudLoadingView: $showCloudLoadingView, selectedLevel: $selectedLevel)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct LevelButton: View {
    let level: Int
    @Binding var showCloudLoadingView: Bool
    @Binding var selectedLevel: Int?

    var body: some View {
        ZStack {
            Image("level\(level)")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(20)
                .shadow(radius: 5)
            VStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        selectedLevel = level
                        showCloudLoadingView = true
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
}

#Preview {
    HomeView()
}

