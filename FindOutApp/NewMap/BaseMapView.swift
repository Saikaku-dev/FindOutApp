import SwiftUI

struct BaseMapView: View {
    @State var showLight=true//路灯按钮判定布尔值
    @State var showPurpleScarf=true//紫色雪人判定布尔值
    @State var showBlueScarf=true//蓝色雪人1判定布尔值
    @State var showBusLeft=true//公交车(左)按钮判定布尔值
    @State var showBusRight=true//公交车(右)按钮判定布尔值
    @State var count : Double=0.0 //更新进度条
    
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
    
    //itemBarSize
    @State private var itemBarOpacity:CGFloat = 1.0
    @State var itemBarButton = false
    
    var body: some View {
        ZStack {
            Image("basic map")
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
                        x=defaultOffset.width + dragOffset.width+60
                        y=defaultOffset.height + dragOffset.height-10
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("street light")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 18,height: 40)
                            .clipped()
                    })
                .offset(x:60,y: -18)
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
                        
                        showAnimation = true
                        coinAnimation()
                        count+=1
                        x=defaultOffset.width + dragOffset.width+310
                        y=defaultOffset.height + dragOffset.height+135
                    }, label: {
                        Image("purple scarf")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35,height: 50)
                            .clipped()
                    })
                .offset(x:310,y: 135)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
            }//if end
            
            //蓝色雪人显示判断
            if(showBlueScarf){
                Button(
                    action: {showBlueScarf.toggle()
                        showAnimation = true
                        x=defaultOffset.width + dragOffset.width-50
                        y=defaultOffset.height + dragOffset.height+110
                        coinAnimation()
                        count+=1}, label: {
                            Image("blue scarf")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50,height: 65)
                                .clipped()
                        })
                .offset(x:-50,y: 110)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
            }//if end
            
            //左斜公交车显示判定
            if(showBusLeft){
                Button(
                    action: {showBusLeft.toggle()
                        x=defaultOffset.width + dragOffset.width-280
                        y=defaultOffset.height + dragOffset.height-140
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("bus left")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70,height: 62)
                            .clipped()
                    })
                
                .offset(x:-280,y:-140)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
            }//if end
            
            //右斜公交车显示判定
            if(showBusRight){
                Button(
                    action: {showBusRight.toggle()
                        x=defaultOffset.width + dragOffset.width+220
                        y=defaultOffset.height + dragOffset.height+100
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("bus right")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 65,height: 53)
                            .clipped()
                    })
                
                .offset(x:220,y:100)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
            }//if end
            
            //圆形进度条
            Gauge(value: count, in: 0...5){
                Text("\(Int(count))/5")
            }
//        currentValueLabel: {
//            Text("\(Int(count))/5")
//        }
        .gaugeStyle(.accessoryCircularCapacity)
        .progressViewStyle(.linear)
        .tint(.blue)
        .background(.white)
        .cornerRadius(35)
        .offset(x:-UIScreen.main.bounds.width/2 + 50,y:-UIScreen.main.bounds.height/4 - 20)
            //进度条结束
            
            //3D动画旋转效果(旋转角度设定)
            if(showAnimation){
                Image("gold")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
//                    .clipShape(Circle())
//                    .overlay(Circle()
//                    .stroke(Color.white,lineWidth: 5))
//                    .shadow(radius: 20)
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
            }//if end 动画启动判断
            
            VStack {
                if itemBarButton {
                    Button(action: {
                        itemBarOpacity = 1.0
                        itemBarButton = false
                    }) {
                        Text("表示")
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(10)
                    }
                }
                Button(action: {
                    itemBar()
                }) {
                    ItemListView()
                        .padding(.horizontal,5)
                        .padding(.vertical,10)
                        .background(.green)
                        .cornerRadius(50)
                        .opacity(itemBarOpacity)
                }
            }
            .position(x:UIScreen.main.bounds.width - 50,y:UIScreen.main.bounds.height/2)
        }//ZStack end
        .edgesIgnoringSafeArea(.all)
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
    
    private func itemBar() {
            itemBarOpacity = 0.0
            itemBarButton = true
    }
}//struct ScaleMapView end

#Preview {
    BaseMapView()
}
