//
//  SettingView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode // 用于关闭视图
    @State var isSound = true
    @State var isMusic = true
    
    var body: some View {
        VStack {
            // 顶部的返回按钮和标题
            HStack {
                // 返回按钮
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // 关闭设置视图，返回HomeView
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                        Text("戻る")
                            .font(.headline)
                    }
                }
                .padding()

                Spacer()

                // 标题
                Text("Setting")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Spacer()

                // 空白占位符使标题居中
                Spacer().frame(width: 50) // 为了让标题保持居中，添加一个宽度相等的占位符
            }
            .padding(.top, 30) // 调整按钮和标题的顶部间距

            Spacer()

            VStack {
                List {
                    Toggle(isOn: $isSound) {
                        Label("音楽", systemImage: "music.note")
                    }
                    Toggle(isOn: $isMusic) {
                        Label("サウンド", systemImage: "speaker.wave.2.fill")
                    }
                    HStack(spacing: 20) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        Text("お問い合わせ")
                    }
                }

                Spacer()
            }
        }
    }
}

#Preview {
    SettingView()
}
