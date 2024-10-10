import SwiftUI

struct CloudView: View {
    @State private var isOpening = false
    
    
    //initialX,initialY为初始值，offsetX为水平移动量
    private let clouds = [
        (name: "cloud1", width: 1400.0, height: 1400.0, initialX: -200.0, initialY: -350.0, offsetX: -800.0),
        (name: "cloud2", width: 1400.0, height: 1400.0, initialX: -150.0, initialY: -150.0, offsetX: -800.0),
        (name: "cloud3", width: 1400.0, height: 1400.0, initialX: -100.0, initialY: 50.0, offsetX: -800.0),
        (name: "cloud4", width: 1400.0, height: 1400.0, initialX: 100.0, initialY: -350.0, offsetX: 800.0),
        (name: "cloud5", width: 1400.0, height: 1400.0, initialX: 150.0, initialY: -150.0, offsetX: 800.0),
        (name: "cloud6", width: 1400.0, height: 1400.0, initialX: 200.0, initialY: 50.0, offsetX: 800.0),
        (name: "cloud7", width: 1400.0, height: 1400.0, initialX: 50, initialY: 300.0, offsetX: -800.0),
        (name: "cloud8", width: 1400.0, height: 1400.0, initialX: 250.0, initialY: 350.0, offsetX: 800.0),
        (name: "cloud9", width: 1400.0, height: 1400.0, initialX: -100, initialY: 50.0, offsetX: -800.0),
        (name: "cloud10", width: 1400.0, height: 1400.0, initialX: 350.0, initialY: 200.0, offsetX: 800.0)
    ]

    var body: some View {
        ZStack {
            
//            Color.clear
//                .edgesIgnoringSafeArea(.all)
            
            ForEach(0..<clouds.count, id: \.self) { index in
                let cloud = clouds[index]
                Image(cloud.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: cloud.width, height: cloud.height)
                    // 根据 isOpening 状态进行偏移
                    .offset(
                        x: isOpening ? cloud.offsetX : cloud.initialX,
                        y: cloud.initialY
                    )
                    .animation(
                        .easeInOut(duration: 2.5)
                            .delay(Double(index) * 0.1), // 为每个云彩设置不同的延时效果
                        value: isOpening
                    )
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 视图加载后，延时 0.5 秒触发动画
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                isOpening = true
//            }
//        }
    }
}

#Preview {
    CloudView()
}
