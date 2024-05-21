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
                            .frame(width: scaledframeheight * 1.25, height: scaledframeheight * 1.25)
                            .padding(sides: [.left], value: scaledframeDefaultSizeOne*293)
                    }
                    HStack(alignment: .center){
                        Text("Artiom")
                            .padding(sides: [.left], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundStyle(Color.brownnr2)
                            .frame(width: scaledframeDefaultSizeOne * 112, height: scaledframeDefaultSizeOne * 8, alignment: .trailing)
                        Image("heart")
                            .resizable()
                            .frame(width: scaledframeDefaultSizeOne * 64, height: scaledframeDefaultSizeOne * 59, alignment: .center)
                        Text("Alexandra")
                            .multilineTextAlignment(.leading)
                            .padding(sides: [.right], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundStyle(Color.brownnr2)
                            .frame(width: scaledframeDefaultSizeOne * 112, height: scaledframeDefaultSizeOne * 8, alignment: .leading)
                    }
                    .frame(width: scaledframeDefaultSizeOne * 308, height: scaledframeDefaultSizeOne * 59, alignment: .center)
                    ZStack{
                        Image("CalendarElementMain")
                            .frame(width: scaledframeDefaultSizeOne * 343, height: scaledframeDefaultSizeOne * 450)
                    }
                }
            }
        }
    }
}

#Preview {
    MainPageView()
}
