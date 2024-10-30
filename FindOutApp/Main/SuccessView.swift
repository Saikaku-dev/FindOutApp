
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
struct SuccessView: View {
    @State private var showConfetti = true
    @State  var moveToHomeView:Bool = false
    var onReturnHome: (() -> Void)?

    var body: some View {
        ZStack {
            // 背景图片
            Image("successbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
         //    彩带喷发效果
            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
            }
            
            // 主内容
            VStack(spacing: 30) {
                // 显示成功的标题文本
                
                    Text(  "クリア！")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                
                // 带阴影和圆角效果的图片
               
                // 返回主页的按钮
                Button("続ける") {
                    
                    // 返回主页操作，游戏完成一定回到主界面
                    moveToHomeView = true
                    onReturnHome?() // 调用重置闭包
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(25)
            }
//            .offset(y: -150)
        }
        .fullScreenCover(isPresented: $moveToHomeView ) {
            HomeView()
        }
//        .onAppear {
//            // 页面加载后1秒钟后关闭彩带效果
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                showConfetti = false
//            }
//        }
    }
}

// 彩带喷发效果视图
struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = [] // 粒子数组
    @State private var animationTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() // 定时器控制动画更新
    
    let particleCount = 200 // 粒子数量

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
                    
                    if elapsedTime < 1 { // 粒子在寿命内显示
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
                // 生成初始的彩带粒子
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
        }
    }

    // 创建粒子数组，生成彩带效果
    func createParticles(count: Int, in size: CGSize) -> [ConfettiParticle] {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink]
        var particles: [ConfettiParticle] = []

        for _ in 0..<count {
            let position = CGPoint(x: size.width / 2, y: size.height * 0.4 + CGFloat.random(in: -10...10)) // 横屏中上方喷发
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
