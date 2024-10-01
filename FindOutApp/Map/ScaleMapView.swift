//
//  ScaleMapView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/09/30.
//

import SwiftUI

struct ScaleMapView: View {
    //计算偏移量用来计算移动后的当前画面
    @State private var defaultOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    //缩放比例
    @State private var defaultScale: CGFloat = 1.0
    @GestureState private var dragScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Image("basicMap")
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
                )
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .scaledToFill()
        .scaleEffect(defaultScale * dragScale)
    }
}

#Preview {
    ScaleMapView()
}
