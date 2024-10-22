//
//  testGameView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/16.
//

import SwiftUI




struct GameView: View {
    @State private var foundItems: Set<String> = [] // 存储已找到的item的imageName
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 1.0
    @GestureState private var dragScale: CGFloat = 1.0
    @ObservedObject var itemdata = ItemCountData.shared
    
    @State private var items: [ItemList] = 
    [
        ItemList(img: "street light", offset: CGSize(width: 50, height: 100)),
        ItemList(img: "purple scarf", offset: CGSize(width: 150, height: 100)),
        ItemList(img: "blue scarf", offset: CGSize(width: 250, height: 100)),
        ItemList(img: "bus left", offset: CGSize(width: -200, height: 100)),
        ItemList(img: "bus right", offset: CGSize(width: -300, height: 100)),
        ItemList(img: "house", offset: CGSize(width: -350, height: 100))
    ]
    @State private var finded:Bool = false
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        GeometryReader { geometry in
            let imageSize = CGSize(width: geometry.size.width * defaultScale,
                                   height: geometry.size.height * defaultScale)
            let maxOffsetX = (imageSize.width - screenSize.width) / 2
            let maxOffsetY = (imageSize.height - screenSize.height) / 2
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                    ZStack {
                        Image("GameBackGround")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        //玩家需要找的元素
                        ForEach(items) { item in
                            Button(action: {
                                shock()
                                itemdata.findedNumber += 1
                                print ("探した数\(itemdata.findedNumber)")
                                print ("総量\(itemdata.totalNumber)")
                                foundItems.insert(item.img) // 将找到的item的imageName添加到集合中
                                if itemdata.findedNumber == itemdata.totalNumber {
                                    // 找到的元素等于总数时的逻辑
                                    
                                }
                            }) {
                                Image(item.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: ItemCountData.shared.imgSize,
                                           height:ItemCountData.shared.imgSize)
                            }
                            .offset(item.offset)
                            .disabled(foundItems.contains(item.img))
                        }
                    }
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
                    )
                HStack {
                    ItemListView(items: $items)
                        .frame(height:UIScreen.main.bounds.height)
                    Spacer()
                }
            }
        }
    }
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
    private func shock() {
        let shockOfFound = UINotificationFeedbackGenerator()
        shockOfFound.prepare()
        // 类型有 .success .error 和 .warning
        //分别对应通知,错误和警告
        shockOfFound.notificationOccurred(.warning)
    }
}

#Preview {
    GameView()
}
