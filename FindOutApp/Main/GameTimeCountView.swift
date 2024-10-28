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
            HStack {
                Gauge(value: Double(gameTime.countTime), in: 0...60) {
                    //
                }
                .progressViewStyle(LinearProgressViewStyle())
                .tint(LinearGradient(colors: [.red,.orange,.yellow], startPoint: .leading, endPoint: .trailing))
                .frame(width:UIScreen.main.bounds.width/2)
                .overlay(
                    RoundedRectangle(cornerRadius:15)
                        .stroke(Color.black,lineWidth: 2)
                )
                Text("\(GameTime.shared.countTime)")
                    .fontWeight(.bold)
                    .font(.title)
            }
            .frame(width:UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    GameTimeCountView()
}
