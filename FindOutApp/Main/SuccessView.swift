//
//  SuccessView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/8.
//


import SwiftUI

// 粒子模型
struct ConfettiParticle {
    var position: CGPoint
    var velocity: CGSize
    var color: Color
    var size: CGSize
    var rotation: Angle
    var rotationSpeed: Angle
    var lifetime: TimeInterval // 粒子寿命
}

// 成功页面视图
// AudioPlayer.swift
import AVFoundation

class SuccessAudioPlayer: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        setupAudio()
    }
    
    private func setupAudio() {
        guard let path = Bundle.main.path(forResource: "歓声と拍手1", ofType: "mp3") else {
            print("音频文件未找到")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = 0 // 只播放一次
        } catch {
            print("音频播放器创建失败: \(error)")
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

// SuccessView.swift
import SwiftUI

struct SuccessView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showConfetti = true
    @StateObject private var audioPlayer = SuccessAudioPlayer()
    var onReturnHome: (() -> Void)?

    var body: some View {
        ZStack {
            // 背景图片
            Image("successbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // 彩带喷发效果
            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
            }
            
            // 主内容
            VStack(spacing: 0) {
                Image("彩带")
                    .resizable()
                    .frame(width: 530, height: 130)
                
                Image("奖杯")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .padding()
                
                // 返回主页的按钮
                Button(action: {
                    // 调用回调函数以返回主页，动画不立即消失
                    onReturnHome?()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        dismiss()  // 延迟 dismiss，以保留动画
                    }
                }) {
                    Text("続ける")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .frame(width: 200)
                .background(Capsule().fill(Color.purple))
            }
        }
        .onAppear {
            // 视图出现时播放音乐
            audioPlayer.play()
        }
        .onDisappear {
            // 视图消失时停止音乐
            audioPlayer.stop()
        }
    }
}

// 其余代码保持不变...
    


// 彩带喷发效果视图
struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = [] // 粒子数组
    @State private var animationTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() // 定时器控制动画更新
    
    let particleCount = 500 // 粒子数量
    
    var body: some View {
        GeometryReader { geometry in
            // 使用 Canvas 绘制彩带效果
            Canvas { context, size in
                for particle in particles {
                    var transformedParticle = particle
                    transformedParticle.position.x += transformedParticle.velocity.width * 0.01
                    transformedParticle.position.y += transformedParticle.velocity.height * 0.01
                    transformedParticle.rotation += transformedParticle.rotationSpeed * 0.01

                    // 计算粒子消失效果
                    let elapsedTime = Date().timeIntervalSinceReferenceDate - particle.lifetime
                    let opacity = max(0, 1 - elapsedTime) // 不透明度逐渐降低
                    let scale = max(0.3, 1 - elapsedTime / 2) // 缩放粒子，逐渐变小

                    if elapsedTime < 3 { // 粒子在寿命内显示
                        context.opacity = opacity // 应用不透明度
                        context.transform = CGAffineTransform(translationX: transformedParticle.position.x, y: transformedParticle.position.y)
                            .rotated(by: transformedParticle.rotation.radians)
                            .scaledBy(x: scale, y: scale) // 缩放效果

                        // 绘制粒子路径
                        let path = Path(CGRect(x: -transformedParticle.size.width / 2, y: -transformedParticle.size.height / 2, width: transformedParticle.size.width, height: transformedParticle.size.height))
                        context.fill(path, with: .color(transformedParticle.color)) // 填充粒子颜色
                    }
                }
            }
            .onAppear {
                // 生成初始的彩带粒子，覆盖整个屏幕区域
                particles = createParticles(count: particleCount, in: geometry.size)
            }
            .onReceive(animationTimer) { _ in
                // 更新粒子并移除过期的粒子
                particles = particles.map { particle in
                    var updatedParticle = particle
                    updatedParticle.position.x += updatedParticle.velocity.width * 0.01
                    updatedParticle.position.y += updatedParticle.velocity.height * 0.01
                    updatedParticle.rotation += updatedParticle.rotationSpeed * 0.01
                    updatedParticle.velocity.width *= 0.99 // 粒子速度逐渐降低
                    updatedParticle.velocity.height *= 0.99
                    return updatedParticle
                }.filter { Date().timeIntervalSinceReferenceDate - $0.lifetime < 1 } // 移除超过寿命的粒子
            }
            .ignoresSafeArea() // 全屏覆盖
        }
    }

    // 创建粒子数组，生成彩带效果
    func createParticles(count: Int, in size: CGSize) -> [ConfettiParticle] {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink]
        var particles: [ConfettiParticle] = []

        for _ in 0..<count {
            let position = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height)) // 全屏随机生成位置
            let velocity = randomVShapeVelocity(for: size) // 随机生成速度
            let color = colors.randomElement() ?? .red
            let size = CGSize(width: CGFloat.random(in: 5...10), height: CGFloat.random(in: 20...40)) // 随机生成尺寸
            let rotation = Angle(degrees: Double.random(in: 0...360))
            let rotationSpeed = Angle(degrees: Double.random(in: -60...60))
            let lifetime = Date().timeIntervalSinceReferenceDate // 设置寿命
            particles.append(ConfettiParticle(position: position, velocity: velocity, color: color, size: size, rotation: rotation, rotationSpeed: rotationSpeed, lifetime: lifetime))
        }

        return particles
    }

    // 随机生成 V 字形的速度
    func randomVShapeVelocity(for size: CGSize) -> CGSize {
        let horizontalSpeed = CGFloat.random(in: -300...300)
        let upwardSpeed = CGFloat.random(in: -300...(-100)) // 控制喷射角度，适应横屏
        return CGSize(width: horizontalSpeed, height: upwardSpeed)
    }
}


#Preview {
    SuccessView()
}
