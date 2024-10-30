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
                Text("\(item.foundCount)/\(itemdata.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}

struct ItemListView21: View {
    @ObservedObject var itemdata21 = ItemCountData.shared
    @EnvironmentObject var itemManager21:ItemManager21

    var body: some View {
        VStack {
            ForEach(itemManager21.items) { item21 in
                Image(item21.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height:20)
                Text("\(item21.foundCount1)/\(itemdata21.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}



struct ItemListView22: View {
    @ObservedObject var itemdata22 = ItemCountData.shared
    @EnvironmentObject var itemManager22:ItemManager22

    var body: some View {
        VStack {
            ForEach(itemManager22.items) { item22 in
                Image(item22.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height:20)
                Text("\(item22.foundCount2)/\(itemdata22.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}



struct ItemListView23: View {
    @ObservedObject var itemdata23 = ItemCountData.shared
    @EnvironmentObject var itemManager23:ItemManager23

    var body: some View {
        VStack {
            ForEach(itemManager23.items) { item23 in
                Image(item23.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height:20)
                Text("\(item23.foundCount3)/\(itemdata23.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}



struct ItemListView2z: View {
    @ObservedObject var itemdata2z = ItemCountData.shared
    @EnvironmentObject var itemManager2z:ItemManager2z
    
    var body: some View {
        VStack {
            ForEach(itemManager2z.items) { item2z in
                Image(item2z.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height:20)
//                
//                if(itemManager2z[0]==0){
//                    Text("\(item21.foundCount1)/2")
//                }
//                else if(itemManager2z[1]==1){
//                    Text("\(item22.foundCount2)/4")
//                }
//                else{Text("\(item23.foundCount3)/4")
//                }
                
//                Text("\(item23.foundCount)/\(itemdata23.totalNumber)")
                
                    .foregroundColor(.black)
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}







//#Preview {
//    ItemListView()
//}
