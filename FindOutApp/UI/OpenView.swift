//
//  OpenView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/1.
//

import SwiftUI


struct OpenView: View {
    @State private var isActive = false // 用于控制导航到下一个页面
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Image("openimage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //保证图片完整显示，占据整个屏幕
                //忽略安全区域
            }
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black) // 整个屏幕背景为黑颜色
            .onAppear {
                // 4秒后导航到LoadingView
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
            
            .navigationDestination(isPresented: $isActive) {
                LoadingView()
            }
        }
    }
}

#Preview {
    OpenView()
}
