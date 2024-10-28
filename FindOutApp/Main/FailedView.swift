import SwiftUI

 

// 失败页面视图
struct FailedView: View {
    @State private var showConfetti = true

    var body: some View {
        ZStack {
            // 背景图片
            Image("successbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            
            // 主内容
            VStack(spacing: 30) {
                // 显示成功的标题文本
                Text("残念！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // 带阴影和圆角效果的图片
               

                // 返回主页的按钮
                Button("続ける") {
                    
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(25)
            }
        }
        
        
    }
}
#Preview {
    FailedView()
}


