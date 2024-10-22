//
//  testGameView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/16.
//

import SwiftUI

struct GameView: View {
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 2.0
    @GestureState private var dragScale: CGFloat = 1.0
    
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        @ObservedObject var itemdata = ItemCountData.shared
        GeometryReader { geometry in
            let imageSize = CGSize(width: geometry.size.width * defaultScale,
                                   height: geometry.size.height * defaultScale)
            let maxOffsetX = (imageSize.width - screenSize.width) / 4
            let maxOffsetY = (imageSize.height - screenSize.height) / 4
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                    ZStack {
                        Image("GameBackGround")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        //玩家需要找的元素
                        ForEach(itemlist) { item in
                            Button(action: {
                                itemdata.findedNumber += 1
                                if itemdata.findedNumber == itemdata.totalNumber {
                                    //如果找到的元素等于总数
                                    
                                }
                            }) {
                                Image(item.img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: ItemCountData.shared.imgSize,
                                           height:ItemCountData.shared.imgSize)
                            }
                            .offset(item.offset)
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
                                    scale = value
                                }
                                .onEnded { value in
                                    defaultScale = min(max(defaultScale * value, 1.0), 4.0)
                                }
                        )
                    )
                HStack {
                    ItemListView()
                        .frame(height:UIScreen.main.bounds.height)
                    Spacer()
                }
            }
        }
    }
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
}

#Preview {
    GameView()
}
