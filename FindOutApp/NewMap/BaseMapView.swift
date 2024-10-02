import SwiftUI

struct BaseMapView: View {
    @State var showLight=true//路灯按钮判定布尔值
    @State var showPurpleScarf=true//紫色雪人判定布尔值
    @State var showBlueScarf=true//蓝色雪人1判定布尔值
    @State var showBusLeft=true//公交车(左)按钮判定布尔值
    @State var showBusRight=true//公交车(右)按钮判定布尔值

    @State var showAnimation=false//3D动画状态布尔值
    @State var animation=0.0//创建变量储存旋转角度
    
    //动画发生位置坐标抓取
    @State private var Position:CGPoint = CGPoint(x:0,y:0)

    //计算偏移量用来计算移动后的当前画面
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    //缩放比例
    @State private var defaultScale: CGFloat = 1.0
    @GestureState private var dragScale: CGFloat = 1.0
    //更新动画发生位置的暂存变量
    @State private var x:CGFloat=0
    @State private var y:CGFloat=0
    
    var body: some View {
        ZStack {
            Image("basic map H")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                .gesture(
                    SimultaneousGesture (
                    DragGesture ()
                        .updating($dragOffset) { value, move, _ in
                            move = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width += value.translation.width
                            defaultOffset.height += value.translation.height
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            scale = value
                        }
                        .onEnded { value in
                            defaultScale *= value
                        }
                    )
                )//gesture end

            //路灯显示判定
            if(showLight){
                Button(
                    action: {showLight.toggle()
                        x=defaultOffset.width + dragOffset.width-19
                        y=defaultOffset.height + dragOffset.height-65
                        showAnimation = true
                        coinAnimation()
                    }, label: {
                        Image("street light H")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 43,height: 17)
                     .clipped()
                    })
                .offset(x:-19,y: -65)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                .gesture(
                    SimultaneousGesture (
                    DragGesture ()
                        .updating($dragOffset) { value, move, _ in
                            move = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width += value.translation.width
                            defaultOffset.height += value.translation.height
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            scale = value
                        }
                        .onEnded { value in
                            defaultScale *= value
                        }
                    )
                )//gesture end
                
            }//if end
            
            //紫色雪人显示判定
            if(showPurpleScarf){
                Button(
                    action: {showPurpleScarf.toggle()
                        x=defaultOffset.width + dragOffset.width+125
                        y=defaultOffset.height + dragOffset.height-330
                        showAnimation = true
                        coinAnimation()
                    }, label: {
                        Image("purple scarf H")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55,height: 40)
                            .clipped()
                    })
                .offset(x:125,y: -330)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                .gesture(
                    SimultaneousGesture (
                    DragGesture ()
                        .updating($dragOffset) { value, move, _ in
                            move = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width += value.translation.width
                            defaultOffset.height += value.translation.height
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            scale = value
                        }
                        .onEnded { value in
                            defaultScale *= value
                        }
                    )
                )//gesture end
            }//if end
    
            //蓝色雪人显示判断
            if(showBlueScarf){
                Button(
                    action: {showBlueScarf.toggle()
                        showAnimation = true
                        x=defaultOffset.width + dragOffset.width+120
                        y=defaultOffset.height + dragOffset.height+50
                        coinAnimation()}, label: {
                        Image("blue scarf H")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55,height: 35)
                            .clipped()
                    })
                .offset(x:120,y: 50)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                .gesture(
                    SimultaneousGesture (
                    DragGesture ()
                        .updating($dragOffset) { value, move, _ in
                            move = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width += value.translation.width
                            defaultOffset.height += value.translation.height
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            scale = value
                        }
                        .onEnded { value in
                            defaultScale *= value
                        }
                    )
                )//gesture end
            }//if end
            
            //左斜公交车显示判定
            if(showBusLeft){
                Button(
                    action: {showBusLeft.toggle()
                        x=defaultOffset.width + dragOffset.width-158
                        y=defaultOffset.height + dragOffset.height+315
                        showAnimation = true
                        coinAnimation()
                    }, label: {
                        Image("left bus H")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50,height: 60)
                            .clipped()
                    })

                .offset(x:-158,y:315)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                .gesture(
                    SimultaneousGesture (
                    DragGesture ()
                        .updating($dragOffset) { value, move, _ in
                            move = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width += value.translation.width
                            defaultOffset.height += value.translation.height
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            scale = value
                        }
                        .onEnded { value in
                            defaultScale *= value
                        }
                    )
                )//gesture end
            }//if end
            
            //右斜公交车显示判定
            if(showBusRight){
                Button(
                    action: {showBusRight.toggle()
                        x=defaultOffset.width + dragOffset.width+120
                        y=defaultOffset.height + dragOffset.height-200
                        showAnimation = true
                        coinAnimation()
                    }, label: {
                        Image("right bus H")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50,height: 60)
                            .clipped()
                    })

                .offset(x:120,y:-200)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                .gesture(
                    SimultaneousGesture (
                    DragGesture ()
                        .updating($dragOffset) { value, move, _ in
                            move = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width += value.translation.width
                            defaultOffset.height += value.translation.height
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            scale = value
                        }
                        .onEnded { value in
                            defaultScale *= value
                        }
                    )
                )//gesture end
            }//if end
        

            //3D动画旋转效果(旋转角度设定)
           if(showAnimation){
                Image("gold H")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.white,lineWidth: 5))
                    .shadow(radius: 20)
                    .rotation3DEffect(
                        .degrees(animation),axis: (x: 0.0, y: 1.0, z: 0.2)
                    )
                    .onAppear {
                        withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)){
                            self.animation+=360
                        }
                    }
                //获取按钮位置坐标的传值（动画发生的位置）
                    .offset(x:x,y:y)
                   // .position(x:1000,y:500)
                }//if end 动画启动判断

        }//ZStack end

    .frame(maxWidth: .infinity,maxHeight: .infinity)
    .scaledToFill()
    .scaleEffect(defaultScale * dragScale)
    }//var body end

//    //3D动画启动函数（1秒消失）
    func coinAnimation(){
        if(showAnimation){
            Task{
                try? await Task.sleep(nanoseconds: 1*1000000000)
                showAnimation = false
            }
        }
    }//function animation end
}//struct ScaleMapView end

#Preview {
    BaseMapView()
}
