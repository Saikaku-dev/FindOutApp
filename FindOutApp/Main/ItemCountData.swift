//
//  ItemCountData.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/22.
//

import Foundation

class ItemCountData:ObservableObject {
    static let shared = ItemCountData()
    let id = UUID()
    var totalNumber = 1
    var imgSize:CGFloat = 30
    @Published var GameWin:Bool = false
    @Published var GameLose:Bool = false
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

class GameTime2:ObservableObject {
    static var shared = GameTime()
    let id = UUID()
    @Published var countTime:Int = 20
    var countDownTimer: Timer?
    
    func stopCountDownTimer() {
        if GameTime.shared.countTime <= 0 {
            GameTime.shared.countDownTimer?.invalidate()
        }
    }
}
