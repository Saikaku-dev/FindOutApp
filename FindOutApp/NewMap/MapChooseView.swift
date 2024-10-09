//
//  MapChooseView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/09.
//

import SwiftUI

struct MapChooseView: View {
    var body: some View {
        HStack {
            ForEach (0..<2,id: \.self) { _ in
                Rectangle()
                    .frame(width:100,height:100)
            }
        }
    }
}

#Preview {
    MapChooseView()
}
