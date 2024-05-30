//
//  CalendarView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 30.05.2024.
//

import SwiftUI

struct CalendarView: View {
    let backgroundBlur = Image("backgroundblur")
    var body: some View {
        
        NavigationStack{
            ZStack{
                backgroundBlur
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack {
                    NavigationLink{
                        Profile()
                        
                    }label:{
                        HStack{
                            Image("artiomkaCatChoosingButton")
                                .resizable()
                                .frame(width:75, height: 75)
                                .padding(sides: [.left], value:293)
                                .padding(.bottom, 28)
                                .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
                        }
                    }
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
