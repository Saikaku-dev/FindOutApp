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
}

let itemlist = [
    ItemList(img: "street light"),
    ItemList(img: "purple scarf"),
    ItemList(img: "blue scarf"),
    ItemList(img: "bus left"),
    ItemList(img: "bus right"),
    ItemList(img: "house"),
]

struct ItemListView: View {
    var body: some View {
        VStack {
            ForEach(itemlist) { item in
                Image(item.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30,height:30)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(100)
            }
        }
    }
}

#Preview {
    ItemListView()
}
