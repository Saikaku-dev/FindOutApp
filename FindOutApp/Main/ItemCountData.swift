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
}

class GameTime:ObservableObject {
    static var shared = GameTime()
    let id = UUID()
    @Published var countTime:Int = 60
    var countDownTimer: Timer?
    
    func stopCountDownTimer() {
        if GameTime.shared.countTime <= 0 {
            GameTime.shared.countDownTimer?.invalidate()
        }
    }
//    func countDown() {
//        if GameTime.shared.countTime > 0 {
//            countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                withAnimation (.linear(duration: 1)) {
//                    GameTime.shared.countTime -= 1
//                }
//            }
//        } else {
//            countDownTimer?.invalidate()
//        }
//    }
}
