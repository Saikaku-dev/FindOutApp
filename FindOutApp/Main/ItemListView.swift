//
//  ItemListView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/10/06.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var itemdata = ItemCountData.shared
    @EnvironmentObject var itemManager: ItemManager
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) { // Reduced spacing from 10 to 8
            // Header Button
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 18)) // Reduced from 20
                    Text("ターゲット")
                        .font(.subheadline) // Changed from headline to subheadline
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .foregroundColor(.white)
                .padding(.vertical, 6) // Reduced from 8
                .padding(.horizontal, 10) // Reduced from 12
                .background(Color.black.opacity(0.6))
                .cornerRadius(8) // Reduced from 10
            }
            
            // Expandable Content
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) { // Reduced spacing from 15 to 8
                    ForEach(itemManager.items) { item in
                        itemGroup(
                            image: item.img,
                            foundCount: item.foundCount,
                            totalCount: itemdata.totalNumber,
                            color: .blue
                        )
                    }
                }
                .padding(8) // Reduced from default padding()
                .background(Color.black.opacity(0.4))
                .cornerRadius(12)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: 200) // Reduced from 220
    }
    
    private func itemGroup(image: String, foundCount: Int, totalCount: Int, color: Color) -> some View {
        HStack(spacing: 8) { // Reduced spacing from 12 to 8
            // Item Icon
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24) // Reduced from 30x30
                .background(color.opacity(0.2))
                .cornerRadius(6) // Reduced from 8
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(color, lineWidth: 1)
                )
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 4) // Reduced height from 6 to 4
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(width: geometry.size.width * CGFloat(foundCount) / CGFloat(totalCount), height: 4)
                        .foregroundColor(color)
                        .animation(.spring(), value: foundCount)
                }
                .cornerRadius(2)
            }
            .frame(height: 4) // Reduced from 6
            
            // Counter
            Text("\(foundCount)/\(totalCount)")
                .font(.caption2) // Changed from caption to caption2
                .foregroundColor(.white)
                .monospacedDigit()
        }
        .padding(.horizontal, 6) // Reduced from 8
        .padding(.vertical, 4) // Reduced from 6
        .background(Color.white.opacity(0.1))
        .cornerRadius(8) // Reduced from 10
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: 1) // Reduced stroke width from 1.5
        )
    }
}

// Preview
struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            ItemListView()
                .environmentObject(ItemManager())
                .padding()
        }
    }
}
import SwiftUI

struct ItemListView2z: View {
    @Binding var foundCounty: Int  // 黄色小孩找到数量
    @Binding var foundCountb: Int  // 黑色小孩找到数量
    @Binding var foundCountg: Int  // 棕色小孩找到数量
    
    @ObservedObject private var itemManager = ItemManager2z()
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 道具栏标题
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 20))
                    Text("ターゲット")
                        .font(.headline)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.black.opacity(0.6))
                .cornerRadius(10)
            }
            
            // 展开的道具列表
            if isExpanded {
                VStack(alignment: .leading, spacing: 15) {
                    // 黄色小孩组
                    itemGroup(
                        image: itemManager.items[0].img,
                        title: "Yellow Kid",
                        foundCount: foundCounty,
                        totalCount: 2,
                        color: .yellow
                    )
                    
                    // 黑色小孩组
                    itemGroup(
                        image: itemManager.items[1].img,
                        title: "Black Kid",
                        foundCount: foundCountb,
                        totalCount: 4,
                        color: .black
                    )
                    
                    // 棕色小孩组
                    itemGroup(
                        image: itemManager.items[2].img,
                        title: "Brown Kid",
                        foundCount: foundCountg,
                        totalCount: 4,
                        color: .brown
                    )
                }
                .padding()
                .background(Color.black.opacity(0.4))
                .cornerRadius(15)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: 220)
    }
    
    private func itemGroup(image: String, title: String, foundCount: Int, totalCount: Int, color: Color) -> some View {
        HStack(spacing: 12) {
            // 物品图标
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .background(color.opacity(0.2))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 1.5)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                // 进度条
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 6)
                            .opacity(0.3)
                            .foregroundColor(.gray)
                        
                        Rectangle()
                            .frame(width: geometry.size.width * CGFloat(foundCount) / CGFloat(totalCount), height: 6)
                            .foregroundColor(color)
                            .animation(.spring(), value: foundCount)
                    }
                    .cornerRadius(3)
                }
                .frame(height: 6)
            }
            
            // 计数
            Text("\(foundCount)/\(totalCount)")
                .font(.caption)
                .foregroundColor(.white)
                .monospacedDigit()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(color, lineWidth: 1.5)
        )
    }
}

// 预览
struct ItemListView2z_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)  // 深色背景便于预览
            ItemListView2z(
                foundCounty: .constant(1),
                foundCountb: .constant(2),
                foundCountg: .constant(3)
            )
            .padding()
        }
    }
}
