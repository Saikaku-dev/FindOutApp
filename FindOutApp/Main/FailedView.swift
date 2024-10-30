import SwiftUI

 

import SwiftUI

struct FailedView: View {
    @State private var moveToHomeView: Bool = false
    var onReturnHome: (() -> Void)?
    
    var body: some View {
        ZStack {
            Image("successbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("残念！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Button("続ける") {
                    onReturnHome?() // 调用重置闭包
                    moveToHomeView = true
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(25)
            }
        }
        .fullScreenCover(isPresented: $moveToHomeView) {
            HomeView()
        }
    }
}

#Preview {
    FailedView()
}
