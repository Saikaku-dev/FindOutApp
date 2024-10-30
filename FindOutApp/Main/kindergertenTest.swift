//
//  kindergertenTest.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/29.
//

import SwiftUI

struct item21 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var foundCount1:Int
}
//地图按钮的类黄色
class ItemManager21:ObservableObject{
    @Published var items:[item21] = [
        item21(img: "yellowKid01", offset: CGSize(width: -280, height: -125),foundCount1:0),
        item21(img: "yellowKid02", offset: CGSize(width: -180, height: -130),foundCount1:0)
    ]
}


struct item22 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var foundCount2:Int
}
//地图按钮的类黑色
class ItemManager22:ObservableObject{
    @Published var items:[item22] = [
        item22(img: "blackKid01", offset: CGSize(width: 220, height: -150),foundCount2:0),
        item22(img: "blackKid02", offset: CGSize(width: -200, height: -180),foundCount2:0),
        item22(img: "blackKid03", offset: CGSize(width: -80, height: -140),foundCount2:0),
        item22(img: "blackKid04", offset: CGSize(width: -50, height: -180),foundCount2:0)
       
    ]
}


struct item23 :Identifiable{
    var id = UUID()
    var img:String
    var offset:CGSize
    var foundCount3:Int
}
//地图按钮的类棕色
class ItemManager23:ObservableObject{
    @Published var items:[item23] = [
        item23(img: "brownKid01", offset: CGSize(width: 10, height: -10),foundCount3:0),
        item23(img: "brownKid02", offset: CGSize(width: -20, height: -100),foundCount3:0),
        item23(img: "brownKid03", offset: CGSize(width: -80, height: -60),foundCount3:0),
        item23(img: "brownKid04", offset: CGSize(width: -110, height: -130),foundCount3:0)
    ]
}


//第二张三张图道具栏
struct item2z :Identifiable{
    var id = UUID()
    var img:String
    var foundCount:Int
    
}
//地图按钮的类
class ItemManager2z:ObservableObject{
    @Published var items:[item2z] = [
        item2z(img: "yellowKid02", foundCount: 2),
        item2z(img: "blackKid04", foundCount: 4),
        item2z(img: "brownKid03", foundCount: 4)
    ]
}

struct kindergertenTest: View {

    @State var count : Double=0.0 //更新进度条
    @State var showAnimation=false//3D动画状态布尔值
    @State var animation=0.0//创建变量储存旋转角度
                    //获取动画发生位置坐标
    @State private var Position:CGPoint = CGPoint(x:0,y:0)
    @State private var findCount:Int = 0//已经找到的数量
                    //更新动画发生位置的暂存变量
//    @State private var x:CGFloat=0
//    @State private var y:CGFloat=0
    //计算偏移量用来计算移动后的当前画面
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
                    //缩放比例
    @State private var defaultScale: CGFloat = 1.0
    @GestureState private var dragScale: CGFloat = 1.0
                    //itemBarSize
    @State private var itemBarOpacity:CGFloat = 1.0
    @State var itemBarButton = false
    @State private var isStarted:Bool = true//游戏开始倒计时
    @State private var countNumber:Int = 3//游戏开始倒计时长度3秒
    
    
    @State private var foundCount1:Int = 0
    @State private var foundCount2:Int = 0
    @State private var foundCount3:Int = 0


    

    @State private var foundItems: Set<String> = [] // 存储已找到的item的imageName
    
    @ObservedObject var itemdata2z = ItemCountData.shared
//    @EnvironmentObject var itemManager2z : ItemManager2z
//    @EnvironmentObject var itemManager21 : ItemManager21
//    @EnvironmentObject var itemManager22 : ItemManager22
//    @EnvironmentObject var itemManager23 : ItemManager22

    @ObservedObject var itemManager2z = ItemManager2z()
    @ObservedObject var itemManager21 = ItemManager21()
    @ObservedObject var itemManager22 = ItemManager22()
    @ObservedObject var itemManager23 = ItemManager23()
    
    @ObservedObject var gameTime = GameTime.shared


    
    let screenSize = UIScreen.main.bounds.size


    var body: some View {
        
                GeometryReader { geometry in
            let imageSize = CGSize(width: geometry.size.width * defaultScale, height: geometry.size.height * defaultScale)
            let maxOffsetX = (imageSize.width - screenSize.width) / 2
            let maxOffsetY = (imageSize.height - screenSize.height) / 2
            
            
            ZStack{
                Image("allKingdergartenMap1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: defaultOffset.width + dragOffset.width,y: defaultOffset.height + dragOffset.height)
                
                //玩家需要找的元素黄色2
                ForEach(itemManager21.items.indices, id: \.self) { index in
                    let item21 = itemManager21.items[index]
                    Button(action: {
//                        itemManager2z.items[index].
                        foundCount1 += 1
                        findCount += 1
                    }) {
                        Image(item21.img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(foundItems.contains(item21.img) ? 0:1)
                            .frame(width: ItemCountData.shared.imgSize,
                                   height:ItemCountData.shared.imgSize)
                    }
                    .offset(item21.offset)
                    
                    //                .disabled(foundItems.contains(item.img))
                }
                
                //玩家需要找的元素黑色4
                ForEach(itemManager22.items.indices, id: \.self) { index in
                    let item22 = itemManager22.items[index]
                    Button(action: {
//                        itemManager22.items[index].
                        foundCount2 += 1
                        findCount += 1
                    }) {
                        Image(item22.img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(foundItems.contains(item22.img) ? 0:1)
                            .frame(width: ItemCountData.shared.imgSize,
                                   height:ItemCountData.shared.imgSize)
                    }
                    .offset(item22.offset)
                    //                .disabled(foundItems.contains(item.img))
                }
                
                
                
                
                //玩家需要找的元素棕色4
                ForEach(itemManager23.items.indices, id: \.self) { index in
                    let item23 = itemManager23.items[index]
                    Button(action: {
                    
//                        itemManager23.items[index].
                        foundCount3 += 1
                        findCount += 1
                    }) {
                        Image(item23.img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(foundItems.contains(item23.img) ? 0:1)
                            .frame(width: ItemCountData.shared.imgSize,
                                   height:ItemCountData.shared.imgSize)
                    }
                    .offset(item23.offset)
                    
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
            
            //时间进度条
            VStack {
                GameTimeCountView()
                Spacer()
            }
            .frame(height:UIScreen.main.bounds.height)
            .offset(y:40)
            
            //            //道具栏
            //            HStack {
            //                ItemListView2z()
            //                    .environmentObject(itemManager2z)
            //                Spacer()
            //            }
            //            .offset(y:150)
            
//            //道具栏
//           
            HStack {
                ItemListView2z(foundCounty: $foundCount1,foundCountb: $foundCount2,foundCountg:$foundCount3)
                    .environmentObject(itemManager2z)
                Spacer()
            }
//                    .offset(x:-350,y:0)
            .offset(y:150)
            

//                    //测试道具栏
//                    VStack{
//                        Image("yellowKid02")
//                        Text("\(foundCount1)/2")
//                        Image("yellowKid02")
//                        Text("\(foundCount2)/2")
//                        Image("yellowKid02")
//                        Text("\(foundCount3)/2")
//                    }
//                    .offset(x:-350,y:0)

            
            //游戏开始倒计时
            if isStarted {
                //开始倒计时
                if countNumber > 0 {
                    Text("\(countNumber)")
                        .font(.system(size:50))
                        .fontWeight(.bold)
                } else {
                    Text("START！")
                        .font(.system(size:50))
                        .fontWeight(.bold)
                }
            }//if isStarted end
            
            
        }//GeometryReader end
    }//var body end

    
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
    
    
}

#Preview {
    kindergertenTest()
}
