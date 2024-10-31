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
            

            VStack (spacing:20){
                
                Text("残念！")
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2)
)
                    
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Image("裂开的奖杯")
                    .resizable()
                    .frame(width: 160,height: 160)
                Text("次はもっと上手くいくはずだよ！")
                
                Button("続ける") {
                    onReturnHome?() // 调用重置闭包
                    moveToHomeView = true
                }
                .frame(width: 200)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(20)
               
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
