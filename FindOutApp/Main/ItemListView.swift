//
//  ItemListView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/06.
//

import SwiftUI

struct ItemList: Identifiable {
    var id = UUID()
    var img: String
    var offset: CGSize
}
let itemlist = [ItemList(img: "street light", offset: CGSize(width: 50, height: 100)),
                ItemList(img: "purple scarf", offset: CGSize(width: 150, height: 100)),
                ItemList(img: "blue scarf", offset: CGSize(width: 250, height: 100)),
                ItemList(img: "bus left", offset: CGSize(width: -200, height: 100)),
                ItemList(img: "bus right", offset: CGSize(width: -300, height: 100)),
                ItemList(img: "house", offset: CGSize(width: -350, height: 100))
]
struct ItemListView: View {
    @ObservedObject var itemdata = ItemCountData.shared
    var body: some View {
        VStack {
            ForEach(itemlist) { item in
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
