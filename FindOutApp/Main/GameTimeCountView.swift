//
//  GameTimeCountView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/24.
//

import SwiftUI

struct GameTimeCountView: View {
    @ObservedObject var gameTime = GameTime.shared
    var body: some View {
        ZStack {
            Gauge(value: Double(gameTime.countTime), in: 0...5) {
                //
            }
            .progressViewStyle(LinearProgressViewStyle())
            .tint(LinearGradient(colors: [.green,.blue], startPoint: .leading, endPoint: .trailing))
            .frame(width:UIScreen.main.bounds.width/2)
//            Button(action: {
//                if GameTime.shared.countTime > 0 {
//                    gameTime.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                        withAnimation (.linear(duration: 1)) {
//                            GameTime.shared.countTime -= 1
//                        }
//                        gameTime.stopCountDownTimer()
//                    }
//                } else {
//                    gameTime.countDownTimer?.invalidate()
//                }
//            }) {
//                Text("開始 \(gameTime.countTime)")
//                    .foregroundColor(.black)
//            }
        }
    }
}

#Preview {
    GameTimeCountView()
}
