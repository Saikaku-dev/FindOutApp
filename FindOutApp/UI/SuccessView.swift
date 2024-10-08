//
//  SuccessView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/8.
//

import SwiftUI

import SwiftUI

// 成功页面视图
struct SuccessView: View {
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("通关成功！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                

                HStack(spacing: 20) {
                    // 返回主页按钮
                    Button(action: {
                        // 返回主页操作
                    }) {
                        Text("ホームに戻る ")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // 继续下一关按钮
                    Button(action: {
                        // 继续下一关操作
                    }) {
                        Text("次のステージへ")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    SuccessView()
}
