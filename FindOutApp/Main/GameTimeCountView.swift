import SwiftUI

struct GameTimeCountView: View {
    @ObservedObject var gameTime = GameTime.shared
    
    var body: some View {
        ZStack {
            
            HStack(spacing: 20) {
                Spacer()
                // 自定义渐变进度条
                Gauge(value: Double(gameTime.countTime), in: 0...60) {
                    EmptyView()
                }
                .gaugeStyle(.linearCapacity) // 自定义样式
                .tint(LinearGradient(colors: [.red, .yellow, .green], startPoint: .leading, endPoint: .trailing))
                .frame(width: UIScreen.main.bounds.width / 2, height: 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                )
                .shadow(color: gameTime.countTime <= 10 ? .red.opacity(0.8) : .clear, radius: gameTime.countTime <= 10 ? 8 : 0)
                .animation(gameTime.countTime <= 10 ? .easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .linear(duration: 1), value: gameTime.countTime)
                .animation(.linear(duration: 1), value: gameTime.countTime)  // 平滑过渡

                // 倒计时数字和闹钟图标
                ZStack {
                    Image("alarm")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    Text("\(gameTime.countTime)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(gameTime.countTime <= 10 ? .red : .primary)
                        .shadow(color: gameTime.countTime <= 10 ? .red.opacity(0.8) : .clear, radius: gameTime.countTime <= 10 ? 8 : 0)
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    GameTimeCountView()
}
