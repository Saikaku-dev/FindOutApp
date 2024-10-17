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
            let maxOffsetX = (imageSize.width - screenSize.width) / 4
            // 200 , 100 = 50
            let maxOffsetY = (imageSize.height - screenSize.height) / 4
            //
            
            ZStack {
                Image("winter map end")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: limitedOffset(defaultOffset.width + dragOffset.width, max: maxOffsetX),
                            y: limitedOffset(defaultOffset.height + dragOffset.height, max: maxOffsetY))
                    .scaleEffect(defaultScale)
                //
                    .gesture(
//                        SimultaneousGesture (
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                defaultOffset.width = limitedOffset(defaultOffset.width + value.translation.width, max: maxOffsetX)
                                defaultOffset.height = limitedOffset(defaultOffset.height + value.translation.height, max: maxOffsetY)
                            }
//                        MagnificationGesture()
//                            .updating($dragScale) { value, scale, _ in
//                                scale = value
//                            }
//                            .onEnded { value in
//                                defaultScale *= value
//                            }
//                        )
                    )
            }
            .edgesIgnoringSafeArea(.all)
            .scaledToFill()
        }
    }
    func limitedOffset(_ offset: CGFloat, max limit: CGFloat) -> CGFloat {
        return max(min(offset, limit), -limit)
    }
}

#Preview {
    testGameView()
}
