//
//  ItemCountData.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/22.
//

import Foundation

class ItemCountData:ObservableObject {
    static var shared = ItemCountData()
    
    let id = UUID()
    @Published var findedNumber = 0
    var totalNumber = 1
    var imgSize:CGFloat = 30
}
