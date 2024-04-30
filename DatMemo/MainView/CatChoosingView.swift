//
//  CatChoosingView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 30.04.2024.
//

import SwiftUI

struct CatChoosingView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 165
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    var body: some View {
        ZStack{
            background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            ZStack{
                VStack(alignment:.center){
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image("artiomkaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: scaledframewidth, height: scaledframewidth)
                    .padding(.bottom, scaledPadding*1.5)
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image("sashenkaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: scaledframewidth, height: scaledframewidth)
                    .padding(.bottom, scaledPadding*1.5)
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image("dimaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: scaledframewidth, height: scaledframewidth)
                }
            }
        }
    }
}

#Preview {
    CatChoosingView()
}
