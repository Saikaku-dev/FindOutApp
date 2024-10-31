
//  ItemListView.swift


import SwiftUI

struct ItemListView: View {
    @ObservedObject var itemdata = ItemCountData.shared
    @EnvironmentObject var itemManager:ItemManager
    
    var body: some View {
        VStack {
            ForEach(itemManager.items) { item in
                Image(item.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height:20)
                Text("\(item.foundCount)/\(itemdata.totalNumber)")
                    .foregroundColor(.black)
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}


//struct balloonListView: View {
//    @ObservedObject var balloon = ItemCountData.shared
//    @EnvironmentObject var balloonManager:BalloonManager
//
//    var body: some View {
//        VStack {
//            ForEach(balloonManager.items) { itemb in
//                Image(itemb.img)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40,height:40)
//                Text("\(itemb.foundCount)/\(balloon.totalNumber)")
//                    .foregroundColor(.black)
//                    .font(.caption2)
//            }
//        }
//        .padding(10)
//        .background(.white)
//        .cornerRadius(15)
//        .overlay(
//            RoundedRectangle(cornerRadius:15)
//                .stroke(Color.black,lineWidth: 2)
//        )
//    }
//}

//struct ItemListView21: View {
//    @ObservedObject var itemdata21 = ItemCountData.shared
//    @EnvironmentObject var itemManager21:ItemManager21
//
//    var body: some View {
//        VStack {
//            ForEach(itemManager21.items) { item21 in
//                Image(item21.img)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20,height:20)
//                Text("\(item21.foundCount1)/\(itemdata21.totalNumber)")
//                    .foregroundColor(.black)
//                    .font(.caption2)
//            }
//        }
//        .padding(10)
//        .background(.white)
//        .cornerRadius(15)
//        .overlay(
//            RoundedRectangle(cornerRadius:15)
//                .stroke(Color.black,lineWidth: 2)
//        )
//    }
//}
//
//
//
//struct ItemListView22: View {
//    @ObservedObject var itemdata22 = ItemCountData.shared
//    @EnvironmentObject var itemManager22:ItemManager22
//
//    var body: some View {
//        VStack {
//            ForEach(itemManager22.items) { item22 in
//                Image(item22.img)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20,height:20)
//                Text("\(item22.foundCount2)/\(itemdata22.totalNumber)")
//                    .foregroundColor(.black)
//                    .font(.caption2)
//            }
//        }
//        .padding(10)
//        .background(.white)
//        .cornerRadius(15)
//        .overlay(
//            RoundedRectangle(cornerRadius:15)
//                .stroke(Color.black,lineWidth: 2)
//        )
//    }
//}



//struct ItemListView23: View {
//    @ObservedObject var itemdata23 = ItemCountData.shared
//    @EnvironmentObject var itemManager23:ItemManager23
//
//    var body: some View {
//        VStack {
//            ForEach(itemManager23.items) { item23 in
//                Image(item23.img)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20,height:20)
//
//                Text("\(item23.foundCount3)/\(itemdata23.totalNumber)")
//                    .foregroundColor(.black)
//                    .font(.caption2)
//            }
//        }
//        .padding(10)
//        .background(.white)
//        .cornerRadius(15)
//        .overlay(
//            RoundedRectangle(cornerRadius:15)
//                .stroke(Color.black,lineWidth: 2)
//        )
//    }
//}



struct ItemListView2z: View {
    @ObservedObject var itemdata2z = ItemCountData.shared
//    @EnvironmentObject var itemManager2z:ItemManager2z
    var itemManager2z:ItemManager2z = ItemManager2z()
    @Binding var foundCounty:Int
    @Binding var foundCountb:Int
    @Binding var foundCountg:Int

    var body: some View {
        VStack {
//            ForEach(itemManager2z.items) { item2z in
//                Image(item2z.img)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20,height:20)
////
////                Image("yellowKid02")
////                    .resizable()
////                    .aspectRatio(contentMode: .fit)
////                    .frame(width: 20,height:20)
////                Text("\()/\(item2z.foundCount)")
//
//                Text("\(foundCounty)/\(item2z.foundCount)")
////                    .foregroundColor(.black)
////                    .font(.caption2)
//            }
            Image("yellowKid02")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20,height:20)
            Text("\(foundCounty)/2")
            
            Image("blackKid04")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20,height:20)
            Text("\(foundCountb)/4")
            
            Image("brownKid03")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20,height:20)
            Text("\(foundCountg)/4")

          
        }
        .padding(10)
        .background(.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius:15)
                .stroke(Color.black,lineWidth: 2)
        )
    }
}




#Preview {
    ItemListView2z(foundCounty:Binding.constant(0), foundCountb: Binding.constant(0), foundCountg: Binding.constant(0))
}
//#Preview {
//    ItemListView23()
//}
