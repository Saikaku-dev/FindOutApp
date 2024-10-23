//
//  ItemListView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/06.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var itemdata = ItemCountData.shared
    @EnvironmentObject var itemManager:ItemManager
    
    var body: some View {
        VStack {
            ForEach(itemManager.items) { item in
                Image(item.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height:20)
                Text("\(item.findedCount)/\(itemdata.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption2)
            }
            .background(.white)
            .cornerRadius(15)
        }
//        .padding(10)
//        .frame(height:300)
    }
}

//#Preview {
//    ItemListView()
//}
