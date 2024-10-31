//
////
////  OpenView.swift
////  FindOutApp
////
////  Created by cmStudent on 2024/10/1.
////
//
//import SwiftUI
//
//// 游戏打开画面，之后跳转到加载页面（使用 opacity 动画过渡）
//struct OpenView: View {
//    @State private var isActive = false // 用于控制导航到下一个页面
//    @State private var showLoadingView = false // 控制 LoadingView 的显示
//
//    var body: some View {
//        ZStack {
//            if !showLoadingView {
//                VStack {
//                    Image("openimage")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                }
//                .edgesIgnoringSafeArea(.all)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.black)
//                .onAppear {
//                    // 2 秒后开始渐隐并显示 LoadingView
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        withAnimation(.easeInOut(duration: 1.0)) {
//                            showLoadingView = true
//                        }
//                    }
//                }
//            }
//
//            if showLoadingView {
//                LoadingView()
//                    .transition(.opacity) // 使用 opacity 过渡效果
//            }
//        }
//    }
//}
//
//#Preview {
//    OpenView()
//}
import SwiftUI

struct OpenView: View {
    @State private var showHomeView = false

    var body: some View {
        ZStack {
            if showHomeView {
                HomeView()
                    .transition(.opacity)
            } else {
                VStack {
                    Image("openimage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showHomeView = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OpenView()
}

