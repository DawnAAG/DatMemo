//
//  CalendarView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 30.05.2024.
//

import SwiftUI

struct CalendarView: View {
    let backgroundBlur = Image("backgroundblur")
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundBlur
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
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
                        .edgesIgnoringSafeArea(.top)
                        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                        
                            if(value.startLocation.x < 20 && value.translation.width > 100) {
                                self.mode.wrappedValue.dismiss()
                            }
                            
                        }))
                VStack {
                    NavigationLink{
                        Profile()
                    }label:{
                        HStack{
                            Image("artiomkaCatChoosingButton")
                                .resizable()
                                .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                                .frame(width:75, height: 75)
                            
                        }
                        .frame(width:75, height: 75)
                    }
                    .padding(sides: [.left], value:293)
                    .padding(.bottom, 28)
                    Image("calendarviewimg")
                        .resizable()
                        .frame(width:371, height: 703)
                        .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                }
            }
        }
    }
}




#Preview {
    CalendarView()
}
