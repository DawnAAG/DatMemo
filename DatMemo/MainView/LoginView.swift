//
//  LoginView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 26.04.2024.
//

import SwiftUI
extension Color {
    static let browney = Color(red: 79 / 255, green: 60 / 255, blue:66 / 255)
}
struct LoginView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 23
    var body: some View {
        ZStack{
            background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            ZStack {
                VStack {
                    HStack{
                        Text("Choose your cat")
                            .font(Font.custom("PressStart2P", size: UIFontMetrics.default.scaledValue(for: 15)))
                            .padding(scaledPadding)
                            .foregroundStyle(Color.browney)
                            .multilineTextAlignment(.center)
                        Text("Choose your partner's cat")
                            .font(Font.custom("PressStart2P", size: UIFontMetrics.default.scaledValue(for: 15)))
                            .padding(scaledPadding)
                            .foregroundStyle(Color.browney)
                            .multilineTextAlignment(.center)
                            
                    
                    }
                    HStack{
                        Button {
                            print("Edit button was tapped")
                        } label: {
                            Image("ChooseButtonCats")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    LoginView()
}
