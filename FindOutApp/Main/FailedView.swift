import SwiftUI

struct FailedView: View {
    @Environment(\.dismiss) var dismiss
    var onReturnHome: (() -> Void)?
    
    var body: some View {
        ZStack {
            Image("successbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("残念！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Image("裂开的奖杯")
                    .resizable()
                    .frame(width: 160, height: 160)
                
                Text("次はもっと上手くいくはずだよ！")
                
                Button(action: {
                    // 调用回调函数以返回主页，动画不立即消失
                    onReturnHome?()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        dismiss()  // 延迟 dismiss，以保留动画
                    }
                }) {
                    Text("続ける")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity) // 使文字水平居中
                }
                .frame(width: 200) // 按钮宽度
                .background(Capsule().fill(Color.purple)) // 圆柱形背景
                
            }

            }
        }
    }
#Preview{
    FailedView()
}
