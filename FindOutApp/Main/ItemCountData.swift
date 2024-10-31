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
<<<<<<< HEAD
    @Published var gameFinish:Bool = false
=======
    @Published var GameWin:Bool = false
    @Published var GameLose:Bool = false
>>>>>>> 14a4e16fe4de3cee03d2fc53584f8d8a83574d1d
}

class GameTime:ObservableObject {
    static var shared = GameTime()
    let id = UUID()

    @Published var countTime:Int = 10
    var countDownTimer: Timer?
//    
//    func stopCountDownTimer() {
//        if GameTime.shared.countTime <= 0 {
//            GameTime.shared.countDownTimer?.invalidate()
//        }
//    }
}
