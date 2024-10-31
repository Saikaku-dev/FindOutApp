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
                
                Button("続ける") {
                    onReturnHome?()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        dismiss()  // 延迟返回
                    }
                }
                .frame(width: 200)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(20)
            }
        }
    }
}
