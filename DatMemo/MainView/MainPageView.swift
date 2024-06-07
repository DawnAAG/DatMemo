//
//  MainPageView.swift
//  DatMemo
//
//  
//
import SwiftUI

struct MainPageView: View {
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 165
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var yourchoice: yourchosencat
    let background = Image("Background")
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack {
                    HStack(alignment: .top) {
                        NavigationLink {
                            Profile()
                        } label: {
                            HStack {
                                Image(imageName(for: yourchoice.ychosenCat))
                                    .resizable()
                                    .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                    .frame(width: 75, height: 75)
                            }
                            .frame(width: 75, height: 75)
                        }
                    }
                    .padding(sides: [.left], value: 293)
                    .padding(.bottom, 28)
                    
                    HStack(alignment: .center) {
                        Text(username.username)
                            .padding(sides: [.left], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: 112, height: 8, alignment: .trailing)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                        
                        Image("heart")
                            .resizable()
                            .frame(width: 64, height: 59, alignment: .center)
                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                        
                        Text(partnersname.partnersname)
                            .multilineTextAlignment(.leading)
                            .padding(sides: [.right], value: 10)
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: 112, height: 8, alignment: .leading)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                    }
                    .frame(width: 308, height: 59, alignment: .center)
                    .padding(.top, 44)
                    
                    NavigationLink {
                        CalendarView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        ZStack {
                            Image("Element1")
                                .resizable()
                                .scaledToFit()
                            Text(Date.now.formatted(.dateTime.month(.wide)))
                                .font(Font.custom("PressStart2P", fixedSize: 24))
                                .foregroundColor(.white)
                                .offset(y: -154)
                                .shadow(color: .shadowblack, radius: 0, x: 3, y: 4)
                            Text(Date.now.formatted(.dateTime.day()))
                                .font(Font.custom("PressStart2P", fixedSize: 96))
                                .foregroundColor(.white)
                                .offset(y: 7)
                                .shadow(color: .shadowblack, radius: 0, x: 3, y: 4)
                            Text(Date.now.formatted(.dateTime.weekday(.wide)))
                                .font(Font.custom("PressStart2P", fixedSize: 16))
                                .foregroundColor(.white)
                                .offset(y: 101)
                                .shadow(color: .shadowblack, radius: 0, x: 3, y: 4)
                        }
                        .frame(width: 343, height: 450)
                    }
                    .padding(.top, 44)
                }
            }
        }
    }
    private func imageName(for chosenCat: Int8) -> String {
            switch chosenCat {
            case 1:
                return "artiomkaCatChoosingButton"
            case 2:
                return "sashenkaCatChoosingButton"
            case 3:
                return "dimaCatChoosingButton"
            default:
                return "ChooseButtonCats"
            }
        }
}



#Preview {
    MainPageView(username: Username(), partnersname: Partnersname(), yourchoice: yourchosencat())
}

