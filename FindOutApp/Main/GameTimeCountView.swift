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
//            Color.black.ignoresSafeArea()
            HStack {
                Gauge(value: Double(gameTime.countTime), in: 0...60) {
                    //
                }
                .progressViewStyle(LinearProgressViewStyle())
                .tint(LinearGradient(colors: [.red,.orange,.yellow,.green,.green], startPoint: .leading, endPoint: .trailing))
                .frame(width:UIScreen.main.bounds.width/2)
                .overlay(
                    RoundedRectangle(cornerRadius:15)
                        .stroke(Color.black,lineWidth: 2)
                )
                ZStack {
                    Image(systemName: "alarm")
                    Circle()
                        .fill(.white)
                        .frame(width: 20)
                    Text("\(GameTime.shared.countTime)")
                        .fontWeight(.bold)
                        .font(.system(size:13))
                }
                .font(.system(size:30))
                .background(.white)
                .cornerRadius(15)
                
            }
            .frame(width:UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    GameTimeCountView()
}
