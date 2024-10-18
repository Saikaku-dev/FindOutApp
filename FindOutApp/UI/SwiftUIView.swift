import SwiftUI

struct SwiftView: View {
    @State private var offset: CGSize = .zero
    @GestureState private var dragoffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // 获取父视图(ZStack)的大小与坐标
                let parentSize = geometry.size

                Rectangle()
                    .fill(.green)
                    .frame(width: parentSize.width / 2, height: parentSize.height / 2)
                
                    .position(x: max(min(offset.width + dragoffset.width + parentSize.width / 4, parentSize.width - parentSize.width / 4), parentSize.width / 4),
                              y: parentSize.height / 2)
                    .gesture(
                        DragGesture()
                            .updating($dragoffset) { move, value, _ in
                                value = move.translation
                            }
                            .onEnded { value in
                                // 限制 offset 在父视图范围内
                                let newOffsetX = offset.width + value.translation.width
                                let halfWidth = parentSize.width / 4
                                
                                // 确保 Rectangle 的位置不超出父视图边界
                                offset.width = max(min(newOffsetX, parentSize.width - halfWidth), -halfWidth)
                            }
                    )
            }
            .background(Color.blue) // 给父视图一个背景颜色
        }
    }
}

#Preview {
    SwiftView()
}
