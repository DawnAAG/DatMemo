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
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let background = Image("Background")
    var body: some View {
        NavigationView{
            ZStack{
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack{
                    HStack(alignment:.top) {
                        NavigationLink{
                            Profile()
                            
                        }label:{
                            HStack{
                                Image("artiomkaCatChoosingButton")
                                    .resizable()
                                    .frame(width:75, height: 75)
                                    .padding(sides: [.left], value:293)
                                    .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                            }
                    }
                    }
                    HStack(alignment: .center){
                        Text("Artiom")
                            .padding(sides: [.left], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundStyle(Color.brownnr2)
                            .frame(width:112, height:8, alignment: .trailing)
                            .shadow(color: .shadowblack, radius: 0, x :1, y: 1)
                        Image("heart")
                            .resizable()
                            .frame(width:64, height:59, alignment: .center)
                            .shadow(color: .shadowblack, radius: 0, x :2, y: 3)
                        Text("Alexandra")
                            .multilineTextAlignment(.leading)
                            .padding(sides: [.right], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundStyle(Color.brownnr2)
                            .frame(width:112, height:8, alignment: .leading)
                            .shadow(color: .shadowblack, radius: 0, x :1, y: 1)
                    }
                    .frame(width:308, height:59, alignment: .center)
                    .padding(.top,44)
                    NavigationLink{
                        CalendarView()
                    }label:{
                        ZStack {
                            Image("Element1")
                                .resizable()
                                .scaledToFit()
                            Text("October")
                                .font(Font.custom("PressStart2P", fixedSize: 24))
                                .foregroundStyle(Color.white)
                                .offset(y:-154)
                                .shadow(color: .shadowblack, radius: 0, x :3, y: 4)
                            Text("28")
                                .font(Font.custom("PressStart2P", fixedSize: 96))
                                .foregroundStyle(Color.white)
                                .offset(y:7)
                                .shadow(color: .shadowblack, radius: 0, x :3, y: 4)
                            Text("Wednesday")
                                .font(Font.custom("PressStart2P", fixedSize: 16))
                                .foregroundStyle(Color.white)
                                .offset(y:101)
                                .shadow(color: .shadowblack, radius: 0, x :3, y: 4)
                        }.frame(width:343, height:450)
                        
                    }.padding(.top,44)
                        
                        
                    
                }
            }
        }
    }
}

#Preview {
    MainPageView()
}
