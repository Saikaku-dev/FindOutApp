//
//  SettingView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/23.
//

import SwiftUI

struct SettingView: View {
    @State var isSound = true
    @State var isMusic = true
    
    var body: some View {
        Spacer()
        Text("Setting")
            .font(.largeTitle)
        VStack{
            List{
                Toggle(isOn:$isSound){
                    Label("音楽",systemImage: "music.note")
                }
                Toggle(isOn:$isMusic){
                    Label("サウンド",systemImage: "speaker.wave.2.fill")
                }
                HStack(spacing:20){
                    Image(systemName: "envelope.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("お問い合わせ")
                }
            }
            
            
            
            Spacer()
        }
    }
}

#Preview {
    SettingView()
}
