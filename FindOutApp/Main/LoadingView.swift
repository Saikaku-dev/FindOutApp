import SwiftUI

struct LoadingView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var showHomeView = false // 控制 HomeView 的显示

    var body: some View {
        ZStack {
            if !showHomeView { // 当 showHomeView 为 false 时显示 LoadingView
                Color.black
                Image("successbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Text("限られた時間内にターゲットを探し出そう！！")
                        .font(.title)
                        .fontWeight(.bold)

                    ProgressView(value: progress,total: 1.0)
                        .colorInvert()
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(width: 200, height: 15)
                        .scaleEffect(x: 1, y: 2)
                        .padding()
                    Text("読み込んでいます...")
                }
                .padding()
                .onAppear {
                    startProgress()
                }
            }

            if showHomeView {
                HomeView()
                    .transition(.opacity) // 使用 opacity 过渡效果
            }
        }
        .onDisappear {
            timer?.invalidate() // 防止内存泄漏
        }
    }

    func startProgress() {
        // 每0.1秒更新一次，持续4秒内走完
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if progress < 1.0 {
                progress += 0.025 // 4秒钟内达到1.0
            } else {
                timer?.invalidate() // 完成时停止计时器
                withAnimation(.easeInOut(duration: 0.5)) {
                    showHomeView = true // 动画渐隐到 HomeView
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}
