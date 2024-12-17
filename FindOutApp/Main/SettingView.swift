import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode // 用于关闭视图
    @ObservedObject var audioManager = AudioManager.shared // 🎶 引入 AudioManager 单例
    @State private var showContactSheet = false // 用于显示联系方式选项
    
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
                Text("設置")
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
                    // 🎶 音乐开关
                    Toggle(isOn: $audioManager.isMusicOn) { // 使用 AudioManager 的 isMusicOn 状态
                        Label("音楽", systemImage: "music.note")
                    }
                    // 在 SettingView 中切换开关不会立即播放或停止音乐，控制在关卡内实现

                    // 🎶 音量进度条
                    VStack(alignment: .leading, spacing: 10) {
                        Label("音量", systemImage: "speaker.wave.2.fill")
                        Slider(value: $audioManager.volume, in: 0...1) // 控制音量
                            .accentColor(.blue) // 设置进度条颜色
                            .onChange(of: audioManager.volume) { newVolume in
                                audioManager.updateVolume(to: Float(newVolume)) // 更新音量
                            }
                    }
                    .padding(.vertical, 10)

                    // 联系方式
                    Button(action: {
                        showContactSheet = true // 点击按钮时显示联系方式
                    }) {
                        HStack(spacing: 20) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                            Text("お問い合わせ")
                        }
                    }
                }
                Spacer()
            }
        }
        .actionSheet(isPresented: $showContactSheet) {
            ActionSheet(
                title: Text("お問い合わせ"),
                message: Text("以下のメールアドレスからご連絡ください。"),
                buttons: [
                    .default(Text("王瑛琦 24CM0105@jec.ac.jp")) ,
                    .default(Text("李宰赫 24CM0139@jec.ac.jp")) ,
                    .default(Text("趙普湘 24CM0123@jec.ac.jp")) ,
                    .cancel()
                ]
            )
        }
    }
}

#Preview {
    SettingView()
}
