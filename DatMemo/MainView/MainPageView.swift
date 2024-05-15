//
//  MainPageView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 15.05.2024.
//

import SwiftUI


struct MainPageView: View {
    let background = Image("Background")
    var body: some View {
        NavigationView{
            ZStack{
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            }
        }
    }
}

#Preview {
    MainPageView()
}
