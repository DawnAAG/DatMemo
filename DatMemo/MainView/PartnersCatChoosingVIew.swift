//
//  CatChoosingView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 30.04.2024.
//

import SwiftUI

struct PartnersCatChoosingView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 165
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var catNumber: Int8 = 0
    @State private var chosenCat: Int8 = 0
    
    
    var body: some View {
        ZStack{
            background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            ZStack{
                HStack(alignment: .top) {
                    Text("")
                                    .foregroundColor(Color.white)
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarItems(leading: Button(action : {
                                        self.mode.wrappedValue.dismiss()
                                    }){
                                        Image(systemName: "arrow.left")
                                            .foregroundColor(Color.white)
                                })
                }
                        }
                        .edgesIgnoringSafeArea(.top)
                        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                        
                            if(value.startLocation.x < 20 && value.translation.width > 100) {
                                self.mode.wrappedValue.dismiss()
                            }
                            
                        }))
                VStack(alignment:.center){
                    Button {
                        print("Your partners cat is ArtiomkaCat")
                        chosenCat = 1
                        print(chosenCat)
                    } label: {
                        Image("artiomkaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: 165, height: 165)
                    .padding(.bottom, scaledPadding*1.5)
                    Button {
                        print("Your partners cat is SashenkaCat")
                        chosenCat = 2
                        print(chosenCat)
                    } label: {
                        Image("sashenkaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: 165, height: 165)
                    .padding(.bottom, scaledPadding*1.5)
                    Button {
                        print("Your partners cat is DimaCat")
                        chosenCat = 3
                        print(chosenCat)
                    } label: {
                        Image("dimaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width:165, height: 165)
                    .padding(.bottom, 30)
                    
                }
            }
        }
    }


#Preview {
    PartnersCatChoosingView()
}

