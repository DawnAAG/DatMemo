//
//  MainPageView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 15.05.2024.
//

import SwiftUI


struct MainPageView: View {
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 165
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    let background = Image("Background")
    var body: some View {
        NavigationView{
            ZStack{
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack{
                    HStack{
                        Image("artiomkaCatChoosingButton")
                            .resizable()
                            .frame(width:75, height: 75)
                            .padding(sides: [.left], value:293)
                    }
                    HStack(alignment: .center){
                        Text("Artiom")
                            .padding(sides: [.left], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundStyle(Color.brownnr2)
                            .frame(width:112, height:8, alignment: .trailing)
                        Image("heart")
                            .resizable()
                            .frame(width:64, height:59, alignment: .center)
                        Text("Alexandra")
                            .multilineTextAlignment(.leading)
                            .padding(sides: [.right], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundStyle(Color.brownnr2)
                            .frame(width:112, height:8, alignment: .leading)
                    }
                    .frame(width:308, height:59, alignment: .center)
                    ZStack{
                        Image("Element1")
                            .resizable()
                            .scaledToFit()
                        Image("Element2")
                            .resizable()
                            .frame(width:343, height:118, alignment: .top)
                            .offset(y:-185)
                    }
                    .frame(width:343, height:450)
                }
            }
        }
    }
}

#Preview {
    MainPageView()
}
