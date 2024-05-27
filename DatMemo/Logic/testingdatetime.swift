//
//  testingdatetime.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 21.05.2024.
//

import SwiftUI

struct testingdatetime: View {
    @State var showingDetail = false

        var body: some View {
            
            ZStack {
                Button(action: {
                    self.showingDetail.toggle()
                }) {
                    Text("Show Detail")
                }.sheet(isPresented: $showingDetail) {
                    DetailView()
            }
            }
        }
}

struct DetailView: View{
    var body:some View{
        VStack{
            Text(Date.now, format: .dateTime.day().month().year())
                        // Oct 7, 2023
                        
                        Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                        // Oct 7, 2023
                        
                        Text(Date.now.formatted(date: .long, time: .omitted))
                        // October 7, 2023
                        
                        Text(Date.now.formatted(date: .complete, time: .omitted))
                        // Saturday, October 7, 2023
                        
                        Text(Date.now.formatted(date: .numeric, time: .omitted))
                        // 10/7/2023
                        
                        Text(Date.now.formatted(date: .omitted, time: .complete))
                        // 6:53:39 PM CDT
                        
                        Text(Date.now.formatted(date: .omitted, time: .standard))
                        // 6:53:39 PM
                        
                        Text(Date.now.formatted(date: .omitted, time: .shortened))
                        // 6:53 PM
                        
                        Text(Date.now.formatted(.dateTime.dayOfYear()))
                        // 280
                        
                        Text(Date.now.formatted(.dateTime.era()))
                        // AD
                        
                        Text(Date.now.formatted(.dateTime.quarter()))
                        // Q4
                        
                        Text(Date.now.formatted(.dateTime.week()))
                        // 40
                        
                        Text(Date.now.formatted(.dateTime.weekday()))
                        // Sat
                        
                        Text(Date.now.formatted(.dateTime.year(.twoDigits)))
                        // 23
                        
                        Text(Date.now.formatted(.dateTime.month(.narrow)))
                        // O (this is an O for October, not a zero)
                        
                        Text(Date.now.formatted(.dateTime.hour(.twoDigits(amPM: .wide))))
                        // 06 PM
            
        }
    }
}

#Preview {
    testingdatetime()
}
