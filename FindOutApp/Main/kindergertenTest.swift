//
//  kindergertenTest.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/29.
//

import SwiftUI

struct item2 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var foundCount:Int
}

//地图按钮的类
class ItemManager2:ObservableObject{
    @Published var items:[item2] = [
        item2(img: "yellowKid01", offset: CGSize(width: -280, height: -125),foundCount:0),
        item2(img: "yellowKid02", offset: CGSize(width: -180, height: -130),foundCount:0),
        item2(img: "blackKid01", offset: CGSize(width: 220, height: 50),foundCount:0),
        item2(img: "blackKid02", offset: CGSize(width: -200, height: 80),foundCount:0),
        item2(img: "blackKid03", offset: CGSize(width: -80, height: 40),foundCount:0),
        item2(img: "blackKid04", offset: CGSize(width: -50, height: 80),foundCount:0),
        item2(img: "brownKid01", offset: CGSize(width: 10, height: 10),foundCount:0),
        item2(img: "brownKid02", offset: CGSize(width: -20, height: 100),foundCount:0),
        item2(img: "brownKid03", offset: CGSize(width: -80, height: 60),foundCount:0),
        item2(img: "brownKid04", offset: CGSize(width: -110, height: 130),foundCount:0)
    ]
}

struct kindergertenTest: View {

//    @State var showYellowKid01=true//
//    @State var showYellowKid02=true//
//    @State var showBlackKid01=true//
//    @State var showBlackKid02=true//
//    @State var showBlackKid03=true//
//    @State var showBlackKid04=true//
//    @State var showBrownKid01=true//
//    @State var showBrownKid02=true//
//    @State var showBrownKid03=true//
//    @State var showBrownKid04=true//
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
    
    @ObservedObject var itemManager2 = ItemManager2()
//    @ObservedObject var itemdata = ItemCountData.shared

    
    let screenSize = UIScreen.main.bounds.size


    var body: some View {
        
        
        GeometryReader { geometry in
            let imageSize = CGSize(width: geometry.size.width * defaultScale,
                                   height: geometry.size.height * defaultScale)
            let maxOffsetX = (imageSize.width - screenSize.width) / 2
            let maxOffsetY = (imageSize.height - screenSize.height) / 2
            
            
            ZStack{
                Image("allKingdergartenMap")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                
                //玩家需要找的元素
                ForEach(itemManager2.items.indices, id: \.self) { index in
                    let item2 = itemManager2.items[index]
                    Button(action: {
                        
                        
                        //                    shock()
                        itemManager2.items[index].foundCount += 1
                        
                        //                    findCount += 1
                        //                    foundItems.insert(item.img) // 将找到的item的imageName添加到集合中
                        
                        //1秒更新一次 成功找到所有items或者时间归零
                        //                    checkGameResult()
                        
                    }) {
                        Image(item2.img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //                        .opacity(foundItems.contains(item.img) ? 0:1)
                            .frame(width: ItemCountData.shared.imgSize,
                                   height:ItemCountData.shared.imgSize)
                    }
                    .offset(item2.offset)
                    
                    //                .disabled(foundItems.contains(item.img))
                }
                
            }//ZStack end
            .scaledToFill()
            .scaleEffect(defaultScale * dragScale)
            .offset(x: limitedOffset(defaultOffset.width + dragOffset.width, max: maxOffsetX),
                    y: limitedOffset(defaultOffset.height + dragOffset.height, max: maxOffsetY))
            .gesture(
                SimultaneousGesture (
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            defaultOffset.width = limitedOffset(defaultOffset.width + value.translation.width, max: maxOffsetX)
                            defaultOffset.height = limitedOffset(defaultOffset.height + value.translation.height, max: maxOffsetY)
                        },
                    MagnificationGesture()
                        .updating($dragScale) { value, scale, _ in
                            let newScale = defaultScale * value
                            if newScale < 1.0 {
                                scale = 1.0 / defaultScale // 限制最小为1，但保持手势平滑
                            } else if newScale > 3.0 {
                                scale = 3.0 / defaultScale // 限制最大为5，但保持手势平滑
                            } else {
                                scale = value // 正常缩放
                            }
                        }
                        .onEnded { value in
                            defaultScale = min(max(defaultScale * value, 1.0), 3.0)
                        }
                )
            )//gesture end
        }//GeometryReader end
    }//var body end

    
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
    
    
}

#Preview {
    kindergertenTest()
}
