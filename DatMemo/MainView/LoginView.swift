//
//  LoginView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 26.04.2024.
//


import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var partnersname: String = ""
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 160
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    var body: some View {
        NavigationView{
            ZStack{
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                ZStack {
                    VStack(alignment: .center) {
                        HStack{
                            Text("Choose your cat")
                                .font(Font.custom("PressStart2P", fixedSize: 15))
                                .foregroundStyle(Color.white)
                                .multilineTextAlignment(.center)
                                .frame(width:scaledframewidth, height: scaledframeheight)
                            Text("Choose your partner's cat")
                                .font(Font.custom("PressStart2P", fixedSize: 15))
                                .foregroundStyle(Color.white)
                                .multilineTextAlignment(.center)
                                .frame(width:scaledframewidth, height: scaledframeheight)
                            
                        }
                        .padding(.bottom,scaledPadding)
                        .padding(.horizontal, scaledPadding)
                        HStack(alignment: .center){
                            NavigationLink {
                                            YourCatChoosingView()
                                        } label: {
                                                Image("ChooseButtonCats")
                                                    .resizable()
                                        }
                                        .frame(width: scaledframewidth, height: scaledframewidth)
                                        .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                            NavigationLink {
                                            PartnersCatChoosingView()
                                        } label: {
                                                Image("ChooseButtonCats")
                                                    .resizable()
                                        }
                                        .frame(width: scaledframewidth, height: scaledframewidth)
                                        .shadow(color: .shadowblack, radius: 0, x :6, y: 5)

                        }
                        .padding(.horizontal,scaledPadding)
                        
                        VStack{
                            ZStack {
                                Image("YourChoosingButton")
                                        .resizable()
                                        .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight)
                                        .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                                TextField(text: $username, prompt: Text("Name")) {
                                       Text("Username")
                                   }
                                .frame(width:218, height: 20)
                                .font(Font.custom("PressStart2P", fixedSize: 20))
                                .foregroundStyle(Color.brownnr2)
                                .padding(.leading, 10)
                                .padding(.top, 53)
                            }
                            .padding(.top, 27)
                            ZStack {
                                Image("PartnersChoosingButton")
                                        .resizable()
                                        .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight)
                                        .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                                TextField(text: $partnersname, prompt: Text("Name")) {
                                       Text("Username")
                                   }
                                .frame(width:218, height: 20)
                                .font(Font.custom("PressStart2P", fixedSize: 20))
                                .foregroundStyle(Color.brownnr2)
                                .padding(.leading, 10)
                                .padding(.top, 53)
                            }
                            .padding(.top, scaledframeDefaultSizeOne*63)
                            NavigationLink {
                                           MainPageView()
                                            .navigationBarBackButtonHidden(true)
                                        } label: {
                                                Image("SetButton")
                                                    .resizable()
                                                    .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                                        }
                                        .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight * 0.75)
                                        .padding(.top, scaledframeDefaultSizeOne*63)
                            
                            
                            
                        }

                    }
                }
            }
        }
    }
}

enum Side: Equatable, Hashable {
    case left
    case right
}

extension View {
    func padding(sides: [Side], value: CGFloat = 8) -> some View {
        HStack(spacing: 0) {
            if sides.contains(.left) {
                Spacer().frame(width: value)
            }
            self
            if sides.contains(.right) {
                Spacer().frame(width: value)
            }
        }
    }
}



#Preview {
    LoginView()
}
