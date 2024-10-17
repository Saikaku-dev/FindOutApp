//
//  testGameView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/16.
//

import SwiftUI

struct testGameView: View {
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var defaultScale: CGFloat = 2.0
//    @GestureState private var dragScale: CGFloat = 1.0
    
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        GeometryReader { geometry in
            let imageSize = CGSize(width: geometry.size.width * defaultScale,
                                   height: geometry.size.height * defaultScale)
            let maxOffsetX = (imageSize.width - screenSize.width) / 2
            let maxOffsetY = (imageSize.height - screenSize.height) / 2
            
            ZStack {
                //背景图&超出屏幕外的大小&
                Image("winter map end")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: limitedOffset(defaultOffset.width + dragOffset.width, max: maxOffsetX),
                            y: limitedOffset(defaultOffset.height + dragOffset.height, max: maxOffsetY))
                    .scaleEffect(defaultScale)
                    .scaledToFill()
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                defaultOffset.width = limitedOffset(defaultOffset.width + value.translation.width, max: maxOffsetX)
                                defaultOffset.height = limitedOffset(defaultOffset.height + value.translation.height, max: maxOffsetY)
                            }
                    )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
}

#Preview {
    testGameView()
}
