//
//  ItemListView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/06.
//

import SwiftUI

class ItemList: Identifiable, ObservableObject {
    let id = UUID()
    @Published var img: String
    @Published var offset: CGSize
//    @Published var findedNumber: Int // 添加 number 属性来记录找到的数量
    
    init(img: String, offset: CGSize) {
        self.img = img
        self.offset = offset
//        self.findedNumber = findedNumber
    }
}

struct ItemListView: View {
    @ObservedObject var itemdata = ItemCountData.shared
    @Binding var items: [ItemList]
    
    var body: some View {
        VStack {
            ForEach(items) { item in
                Image(item.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30,height:30)
                Text("\(itemdata.findedNumber)/\(itemdata.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(100)
    }
}

#Preview {
    ItemListView()
}
