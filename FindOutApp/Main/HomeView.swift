import SwiftUI

struct HomeView: View {
    @State private var showCloudLoadingView = false
    @State private var selectedLevel: Int? = nil
    @State private var showGameView = false
    @State private var showKindergartenView = false
    @State private var showSettingSheet = false // 用于控制SettingView的展示

    var body: some View {
        ZStack {
            if showGameView {
                GameView()
                    .transition(.opacity)
            } else if showKindergartenView {
                KindergartenTest()
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
                        Button(action: { showSettingSheet = true }) { // 打开设置Sheet
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
                .sheet(isPresented: $showSettingSheet) { // 展示设置页面的sheet
                    SettingView()
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
