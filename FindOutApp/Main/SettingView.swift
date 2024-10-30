import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode // 用于关闭视图
    @State var isSound = true
    @State var musicVolume: Double = 0.5 // 音量进度条的初始值，范围为0到1
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
                    // 音乐开关
                    Toggle(isOn: $isSound) {
                        Label("音楽", systemImage: "music.note")
                    }

                    // 音量进度条
                    VStack(alignment: .leading, spacing: 10) {
                        Label("音量", systemImage: "speaker.wave.2.fill")
                        Slider(value: $musicVolume, in: 0...1) // 音量进度条，范围从0到1
                            .accentColor(.blue) // 设置进度条颜色
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
                    .default(Text("王瑛琦 24CM0105@gmail.jec.ac.jp")) ,
                    .default(Text("李宰赫 24CM0139@gmail.jec.ac.jp")) ,
                    .default(Text("趙普湘 24CM0123@gmail.jec.ac.jp")) ,
                    .cancel()
                ]
            )
        }
    }
    
   
    
}

#Preview {
    SettingView()
}
