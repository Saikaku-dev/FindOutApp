import SwiftUI

struct BaseMapView: View {
    @State var showLight=true//路灯按钮判定布尔值
    @State var showPurpleScarf=true//紫色雪人判定布尔值
    @State var showBlueScarf=true//蓝色雪人1判定布尔值
    @State var showBusLeft=true//公交车(左)按钮判定布尔值
    @State var showBusRight=true//公交车(右)按钮判定布尔值
    @State var showHouse=true//房子按钮判定布尔值
    @State var count : Double=0.0 //更新进度条
    @State var showAnimation=false//3D动画状态布尔值
    @State var animation=0.0//创建变量储存旋转角度
    
    //动画发生位置坐标抓取
    @State private var Position:CGPoint = CGPoint(x:0,y:0)
    
    //计算偏移量用来计算移动后的当前画面
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    //缩放比例
    @State private var defaultScale: CGFloat = 2.0
    @GestureState private var dragScale: CGFloat = 1.0
    //更新动画发生位置的暂存变量
    @State private var x:CGFloat=0
    @State private var y:CGFloat=0
    
    //itemBarSize
    @State private var itemBarOpacity:CGFloat = 1.0
    @State var itemBarButton = false
    
    var body: some View {
        ZStack{
        ZStack {
            Image("winter map end")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
            
            //路灯显示判定
            if(showLight){
                Button(
                    action: {showLight.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                        y=defaultOffset.height + dragOffset.height+44
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("street light")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 12,height: 28)
                            .clipped()
                    })
                //                .offset(x:255,y: 44)
                .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                
            }//if end
            
            //紫色雪人显示判定
            if(showPurpleScarf){
                Button(
                    action: {showPurpleScarf.toggle()
                        
                        showAnimation = true
                        coinAnimation()
                        count+=1
                        x=defaultOffset.width + dragOffset.width+385
                        y=defaultOffset.height + dragOffset.height+72
                    }, label: {
                        Image("purple scarf")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25,height: 35)
                            .clipped()
                    })
                //                .offset(x:385,y: 72)
                .offset(x: defaultOffset.width + dragOffset.width+385,y: defaultOffset.height + dragOffset.height+72)
            }//if end
            
            
            //紫色雪人显示判定
            if(showHouse){
                Button(
                    action: {showHouse.toggle()
                        
                        showAnimation = true
                        coinAnimation()
                        count+=1
                        x=defaultOffset.width + dragOffset.width+250
                        y=defaultOffset.height + dragOffset.height+190
                    }, label: {
                        Image("house")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40,height: 40)
                            .clipped()
                    })
                //                .offset(x:385,y: 72)
                .offset(x: defaultOffset.width + dragOffset.width+250,y: defaultOffset.height + dragOffset.height+190)
            }//if end
            
            
            //蓝色雪人显示判断
            if(showBlueScarf){
                Button(
                    action: {showBlueScarf.toggle()
                        showAnimation = true
                        x=defaultOffset.width + dragOffset.width-50
                        y=defaultOffset.height + dragOffset.height+130
                        coinAnimation()
                        count+=1}, label: {
                            Image("blue scarf")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30,height: 41)
                                .clipped()
                        })
                //                .offset(x:-50,y: 130)
                .offset(x: defaultOffset.width + dragOffset.width-50,y: defaultOffset.height + dragOffset.height+130)
            }//if end
            
            
            //左斜公交车显示判定
            if(showBusLeft){
                Button(
                    action: {showBusLeft.toggle()
                        x=defaultOffset.width + dragOffset.width-280
                        y=defaultOffset.height + dragOffset.height-100
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("bus left")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45,height: 40)
                            .clipped()
                    })
                
                //                .offset(x:-280,y:-100)
                .offset(x: defaultOffset.width + dragOffset.width-280,y: defaultOffset.height + dragOffset.height-100)
            }//if end
            
            
            //右斜公交车显示判定
            if(showBusRight){
                Button(
                    action: {showBusRight.toggle()
                        x=defaultOffset.width + dragOffset.width+160
                        y=defaultOffset.height + dragOffset.height+125
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("bus right")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 47,height: 37)
                            .clipped()
                    })
                
                //                .offset(x:238,y:80)
                .offset(x: defaultOffset.width + dragOffset.width+160,y: defaultOffset.height + dragOffset.height+125)
            }//if end
            
            
            //圆形进度条
            Gauge(value: count, in: 0...5){
                Text("\(Int(count))/6")
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
            
            
            
        }//ZStack end
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
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .scaledToFill()
        .scaleEffect(defaultScale * dragScale)
//            VStack {
//                if itemBarButton {
//                    Button(action: {
//                        itemBarOpacity = 1.0
//                        itemBarButton = false
//                    }) {
//                        Text("表示")
//                            .foregroundColor(.black)
//                            .padding(.horizontal)
//                            .background(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                Button(action: {
//                    itemBar()
//                }) {
//                    ItemListView()
//                        .padding(.horizontal,5)
//                        .padding(.vertical,10)
//                        .background(.green)
//                        .cornerRadius(50)
//                        .opacity(itemBarOpacity)
//                }
//            }
//            .frame(width:50,height:100)
        //结果测试
//        Button(action: {
//            
//        }) {
//            Circle()
//                .fill(.red)
//                .frame(width:100)
//        }
    }
}//var body end
    
    //3D动画启动函数（1秒消失）
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
