//
//  kindergartenMap.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/29.
//

import SwiftUI

struct kindergartenMap: View {
    
    
    //第一张地图道具栏的类
    class ItemManager:ObservableObject{
        @Published var items:[item] = [
            item(img: "yellowKid04", offset: CGSize(width: 50, height: 100),foundCount:0),
            item(img: "brownKid02", offset: CGSize(width: 150, height: 100),foundCount:0),
            item(img: "blackKid04", offset: CGSize(width: 250, height: 100),foundCount:0)
        ]
    }
   
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    kindergartenMap()
}
