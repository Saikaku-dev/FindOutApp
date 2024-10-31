import SwiftUI

struct CloudLoadingView: View {
    @Binding var showCloudLoadingView: Bool
    @Binding var selectedLevel: Int?
    @Binding var showGameView: Bool
    @Binding var showKindergartenView: Bool
    @State private var cloudsOpening = false

    private let clouds = [
        (name: "cloud1", width: 1400.0, height: 1400.0, initialX: -20.0, initialY: -100.0, offsetX: -800.0),
        (name: "cloud2", width: 1400.0, height: 1400.0, initialX: -140, initialY: -150.0, offsetX: -800.0),
        (name: "cloud3", width: 1400.0, height: 1400.0, initialX: -160.0, initialY: 50.0, offsetX: -800.0),
        (name: "cloud4", width: 1400.0, height: 1400.0, initialX: 350.0, initialY: -150.0, offsetX: 800.0),
        (name: "cloud5", width: 1400.0, height: 1400.0, initialX: 150.0, initialY: -150.0, offsetX: 800.0),
        (name: "cloud6", width: 1400.0, height: 1400.0, initialX: 200.0, initialY: 50.0, offsetX: 800.0),
        (name: "cloud7", width: 1400.0, height: 1400.0, initialX: 100.0, initialY: 300.0, offsetX: -800.0),
        (name: "cloud8", width: 1400.0, height: 1400.0, initialX: 440.0, initialY: 80.0, offsetX: 800.0),
        (name: "cloud9", width: 1400.0, height: 1400.0, initialX: -140, initialY: 100.0, offsetX: -800.0),
        (name: "cloud10", width: 1400.0, height: 1400.0, initialX: 350.0, initialY: 200.0, offsetX: 800.0)
    ]
    var body: some View {
        ZStack {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 220, height: 240)
                Text("限られた時間内にターゲットを探し出そう！！")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
            }
            .opacity(cloudsOpening ? 1.0 : 0.0) // 云层完全打开后显示加载内容
            .onAppear {
                startCloudAnimation()
            }

            // 云层动画
            ZStack {
                ForEach(0..<clouds.count, id: \.self) { index in
                    let cloud = clouds[index]
                    Image(cloud.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: cloud.width, height: cloud.height)
                        .offset(
                            x: cloudsOpening ? cloud.offsetX : cloud.initialX,
                            y: cloud.initialY
                        )
                        .animation(
                            .easeInOut(duration: 2.5)
                                .delay(Double(index) * 0.1),
                            value: cloudsOpening
                        )
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    cloudsOpening = true
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // 云彩完全展开后自动切换视图
    func startCloudAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { // 延迟3.5秒以延长停留时间
            if selectedLevel == 1 {
                withAnimation {
                    showGameView = true
                }
            } else if selectedLevel == 2 {
                withAnimation {
                    showKindergartenView = true
                }
            }
            showCloudLoadingView = false // 关闭 CloudLoadingView
        }
    }
}

#Preview {
    CloudLoadingView(
        showCloudLoadingView: .constant(true),
        selectedLevel: .constant(1),
        showGameView: .constant(false),
        showKindergartenView: .constant(false)
    )
}
