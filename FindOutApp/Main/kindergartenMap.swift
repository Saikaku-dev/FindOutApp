//
//  kindergartenMap.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/29.
//

import SwiftUI

struct kindergartenMap: View {
    
@State var showYellowKid01=true//
@State var showYellowKid02=true//
@State var showBlackKid01=true//
@State var showBlackKid02=true//
@State var showBlackKid03=true//
@State var showBlackKid04=true//
@State var showBrownKid01=true//
@State var showBrownKid02=true//
@State var showBrownKid03=true//
@State var showBrownKid04=true//


@State var count : Double=0.0 //更新进度条
@State var showAnimation=false//3D动画状态布尔值
@State var animation=0.0//创建变量储存旋转角度

                //获取动画发生位置坐标
@State private var Position:CGPoint = CGPoint(x:0,y:0)
                //更新动画发生位置的暂存变量
@State private var x:CGFloat=0
@State private var y:CGFloat=0
                
                //计算偏移量用来计算移动后的当前画面
@State private var defaultOffset: CGSize = .zero
@GestureState private var dragOffset: CGSize = .zero
                //缩放比例
@State private var defaultScale: CGFloat = 1.0
@GestureState private var dragScale: CGFloat = 1.0
                //itemBarSize
@State private var itemBarOpacity:CGFloat = 1.0
@State var itemBarButton = false
    var body: some View {
        ZStack {
            Image("kindergartenMap")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
            
            if(showYellowKid01){
                Button(
                    action: {showYellowKid01.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                                    y=defaultOffset.height + dragOffset.height+44
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("yellowKid01")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 12,height: 28)
                                        .clipped()
                                })
            //                .offset(x:255,y: 44)
                            .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                            
                        }//if end
                    
            if(showYellowKid02){
                Button(
                    action: {showYellowKid02.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                                    y=defaultOffset.height + dragOffset.height+44
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("yellowKid02")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 12,height: 28)
                                        .clipped()
                                })
            //                .offset(x:255,y: 44)
                            .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                            
                        }//if end
                
            
            
            if(showBlackKid01){
                Button(
                    action: {showBlackKid01.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                                    y=defaultOffset.height + dragOffset.height+44
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("blackKid01")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 12,height: 28)
                                        .clipped()
                                })
            //                .offset(x:255,y: 44)
                            .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                            
                        }//if end
            
            
                        
            if(showBlackKid02){
                Button(
                    action: {showBlackKid02.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                                    y=defaultOffset.height + dragOffset.height+44
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("blackKid02")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 12,height: 28)
                                        .clipped()
                                })
            //                .offset(x:255,y: 44)
                            .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                            
                        }//if end
                        
                        
            if(showBlackKid03){
                Button(
                    action: {showBlackKid03.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                                    y=defaultOffset.height + dragOffset.height+44
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("blackKid03")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 12,height: 28)
                                        .clipped()
                                })
            //                .offset(x:255,y: 44)
                            .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                        }//if end
                        
                        
            if(showBlackKid04){
                Button(
                    action: {showBlackKid04.toggle()
                        x=defaultOffset.width + dragOffset.width+255
                                    y=defaultOffset.height + dragOffset.height+44
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("blackKid04")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 12,height: 28)
                                        .clipped()
                                })
            //                .offset(x:255,y: 44)
                            .offset(x: defaultOffset.width + dragOffset.width+255,y: defaultOffset.height + dragOffset.height+44)
                            
                        }//if end
                        
                        
                        if(showBrownKid01){
                            Button(
                                action: {showBrownKid01.toggle()
                                    x=defaultOffset.width + dragOffset.width+160
                                    y=defaultOffset.height + dragOffset.height+125
                                    showAnimation = true
                                    coinAnimation()
                                    count+=1
                                }, label: {
                                    Image("brownKid01")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 47,height: 37)
                                        .clipped()
                                })
                            
            //                .offset(x:238,y:80)
                            .offset(x: defaultOffset.width + dragOffset.width+160,y: defaultOffset.height + dragOffset.height+125)
                        }//if end
            
            if(showBrownKid02){
                Button(
                    action: {showBrownKid02.toggle()
                        x=defaultOffset.width + dragOffset.width+160
                        y=defaultOffset.height + dragOffset.height+125
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("brownKid02")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 47,height: 37)
                            .clipped()
                    })
                
//                .offset(x:238,y:80)
                .offset(x: defaultOffset.width + dragOffset.width+160,y: defaultOffset.height + dragOffset.height+125)
            }//if end
            
            if(showBrownKid03){
                Button(
                    action: {showBrownKid03.toggle()
                        x=defaultOffset.width + dragOffset.width+160
                        y=defaultOffset.height + dragOffset.height+125
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("brownKid03")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 47,height: 37)
                            .clipped()
                    })
                
//                .offset(x:238,y:80)
                .offset(x: defaultOffset.width + dragOffset.width+160,y: defaultOffset.height + dragOffset.height+125)
            }//if end
            
            if(showBrownKid04){
                Button(
                    action: {showBrownKid04.toggle()
                        x=defaultOffset.width + dragOffset.width+160
                        y=defaultOffset.height + dragOffset.height+125
                        showAnimation = true
                        coinAnimation()
                        count+=1
                    }, label: {
                        Image("brownKid04")
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
                        
                        //道具栏
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
                        }//VStack end
                        .position(x:UIScreen.main.bounds.width - 50,y:UIScreen.main.bounds.height/2)
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
            

}

#Preview {
    kindergartenMap()
}
