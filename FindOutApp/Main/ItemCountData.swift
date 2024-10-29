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
    var totalNumber = 1
    var imgSize:CGFloat = 30
    var gameFinish:Bool = false
}

class GameTime:ObservableObject {
    static var shared = GameTime()
    let id = UUID()

    @Published var countTime:Int = 30
    var countDownTimer: Timer?
//    
//    func stopCountDownTimer() {
//        if GameTime.shared.countTime <= 0 {
//            GameTime.shared.countDownTimer?.invalidate()
//        }
//    }
}
