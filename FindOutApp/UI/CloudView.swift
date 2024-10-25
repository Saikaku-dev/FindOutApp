import SwiftUI

struct CloudView: View {
    @Binding var isOpening: Bool // 控制 CloudView 的显示状态
    @Binding var showGameView: Bool // 控制 GameView 的显示状态
    @State private var cloudsOpening = false // 控制云彩动画

    // initialX, initialY 为初始值，offsetX 为水平移动量
    private let clouds = [
        (name: "cloud1", width: 1400.0, height: 1400.0, initialX: -20.0, initialY: -100.0, offsetX: -800.0),
        (name: "cloud2", width: 1400.0, height: 1400.0, initialX: -140, initialY: -150.0, offsetX: -800.0),   //左上
        (name: "cloud3", width: 1400.0, height: 1400.0, initialX: -160.0, initialY: 50.0, offsetX: -800.0),
        (name: "cloud4", width: 1400.0, height: 1400.0, initialX: 350.0, initialY: -150.0, offsetX: 800.0),  //右上
        (name: "cloud5", width: 1400.0, height: 1400.0, initialX: 150.0, initialY: -150.0, offsetX: 800.0),
        (name: "cloud6", width: 1400.0, height: 1400.0, initialX: 200.0, initialY: 50.0, offsetX: 800.0),
        (name: "cloud7", width: 1400.0, height: 1400.0, initialX: 100.0, initialY: 300.0, offsetX: -800.0),   // 底部中间
        (name: "cloud8", width: 1400.0, height: 1400.0, initialX: 440.0, initialY: 80.0, offsetX: 800.0),    // 右中
        (name: "cloud9", width: 1400.0, height: 1400.0, initialX: -140, initialY: 100.0, offsetX: -800.0),
        (name: "cloud10", width: 1400.0, height: 1400.0, initialX: 350.0, initialY: 200.0, offsetX: 800.0)
    ]

    var body: some View {
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
                            .delay(Double(index) * 0.1), // 为每个云彩设置不同的延时效果
                        value: cloudsOpening
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            // 延时 0.5 秒触发动画
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cloudsOpening = true
            }
            // 动画结束后，切换到 GameView
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isOpening = false // 关闭 CloudView
                    showGameView = true // 显示 GameView
                }
            }
        }
    }
}

#Preview {
    CloudView(isOpening: .constant(true), showGameView: .constant(false))
}
