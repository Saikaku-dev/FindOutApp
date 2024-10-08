//
//  FailedView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/8.
//

import SwiftUI

struct FailedView: View {
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("クリア失敗")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Image(systemName: "xmark.circle.fill")
                //最好替换成灰色的关卡图片
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                

                Button(action: {
                    // 返回主页或重试关卡
                }) {
                    Text("ホームに戻る ")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
  
        FailedView()
        
}
