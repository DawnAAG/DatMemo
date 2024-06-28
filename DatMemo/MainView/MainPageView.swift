//
//  MainPageView.swift
//  DatMemo
//
//
//
import SwiftUI

struct MainPageView: View {
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 100
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat
    let background = Image("Background")
    
    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            NavigationView {
                ZStack {
                    background
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    
                    VStack {
                        HStack(alignment: .top) {
                            NavigationLink {
                                Profile(yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)
                            } label: {
                                HStack {
                                    Image(imageName(for: yourchoice.ychosenCat))
                                        .resizable()
                                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                        .frame(width: scaledsize * (isSmallDevice ? 0.6 : 0.75), height: scaledsize * (isSmallDevice ? 0.6 : 0.75))
                                }
                                .frame(width: scaledsize * (isSmallDevice ? 0.6 : 0.75), height: scaledsize * (isSmallDevice ? 0.6 : 0.75))
                            }
                        }
                        .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 2.88 : 2.93))
                        .padding(.bottom, scaledsize * (isSmallDevice ? 0.2 : 0.28))
                        
                        HStack(alignment: .center) {
                            Text(username.username)
                                .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.085 : 0.1))
                                .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 8 : 8)))
                                .foregroundColor(Color.brownnr2)
                                .frame(width: scaledsize * (isSmallDevice ? 1.12 : 1.12), height: scaledsize * (isSmallDevice ? 0.08 : 0.08), alignment: .trailing)
                                .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                            
                            Image("heart")
                                .resizable()
                                .frame(width: scaledsize * (isSmallDevice ? 0.49 : 0.64), height: scaledsize * (isSmallDevice ? 0.44 : 0.59), alignment: .center)
                                .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                            
                            Text(partnersname.partnersname)
                                .multilineTextAlignment(.leading)
                                .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.085 : 0.1))
                                .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 8 : 8)))
                                .foregroundColor(Color.brownnr2)
                                .frame(width: scaledsize * (isSmallDevice ? 1.12 : 1.12), height: scaledsize * (isSmallDevice ? 0.08 : 0.08), alignment: .leading)
                                .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                        }
                        .frame(width: scaledsize * 3.08, height: scaledsize * 0.59, alignment: .center)
                        .padding(.top, scaledsize * (isSmallDevice ? 0.1 : 0.44))
                        
                        NavigationLink {
                            CalendarView(yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack {
                                Image("Element1")
                                    .resizable()
                                    .scaledToFit()
                                Text(Date.now.formatted(.dateTime.month(.wide)))
                                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 22 : 24)))
                                    .foregroundColor(.white)
                                    .offset(y: (isSmallDevice ? -154 : -154))
                                    .shadow(color: .shadowblack, radius: 0, x: 3, y: 4)
                                Text(Date.now.formatted(.dateTime.day()))
                                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 90 : 96)))
                                    .foregroundColor(.white)
                                    .offset(y: (isSmallDevice ? 7 : 7))
                                    .shadow(color: .shadowblack, radius: 0, x: 3, y: 4)
                                Text(Date.now.formatted(.dateTime.weekday(.wide)))
                                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 14 : 16)))
                                    .foregroundColor(.white)
                                    .offset(y: (isSmallDevice ? 101 : 101))
                                    .shadow(color: .shadowblack, radius: 0, x: 3, y: 4)
                            }
                            .frame(width: scaledsize * (isSmallDevice ? 3.18 : 3.43), height: scaledsize * (isSmallDevice ? 4.25 : 4.5))
                        }
                        .padding(.top, (isSmallDevice ? 24 : 44))
                    }
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
    MainPageView(yourchoice: yourchosencat(),username: Username(), partnersname: Partnersname(), partnerschosencat: partnerschosencat())
}

