import SwiftUI

class Username: ObservableObject {
    @Published var username: String = ""
}

class Partnersname: ObservableObject {
    @Published var partnersname: String = ""
}

struct LoginView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 160
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    @State var buttonOffset: CGFloat = 0
    @State private var showErrorText = false
    
    @StateObject var yourchoice = yourchosencat()
    @StateObject var partnerschoice = partnerschosencat()
    @ObservedObject var username = Username()
    @ObservedObject var partnersname = Partnersname()
    
    @State private var showError = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var showNextView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center) {
                    HStack {
                        Text("Choose your cat")
                            .font(Font.custom("PressStart2P", fixedSize: 15))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: scaledframewidth, height: scaledframeheight)
                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                        Text("Choose your partner's cat")
                            .font(Font.custom("PressStart2P", fixedSize: 15))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: scaledframewidth, height: scaledframeheight)
                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                    }
                    .padding(.bottom, scaledPadding)
                    .padding(.horizontal, scaledPadding)
                    
                    HStack(alignment: .center) {
                        NavigationLink {
                            YourCatChoosingView().environmentObject(yourchoice)
                        } label: {
                            ImageForCatChoice(imageName: imageName(for: yourchoice.ychosenCat))
                        }
                        .frame(width: scaledframewidth, height: scaledframewidth)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                        
                        NavigationLink {
                            PartnersCatChoosingView().environmentObject(partnerschoice)
                        } label: {
                            ImageForCatChoice(imageName: imageName(for: partnerschoice.pchosenCat))
                        }
                        .frame(width: scaledframewidth, height: scaledframewidth)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                    }
                    .padding(.horizontal, scaledPadding)
                    
                    VStack {
                        ZStack {
                            Image("YourChoosingButton")
                                .resizable()
                                .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight)
                                .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                            TextField(text: $username.username, prompt: Text("Name")) {
                                Text("Username")
                            }
                            .frame(width: scaledframeButtonWidth * 0.87, height: scaledframeButtonHeight * 0.2)
                            .font(Font.custom("PressStart2P", fixedSize: 20))
                            .foregroundColor(.brownnr2)
                            .padding(.leading, 10)
                            .padding(.top, scaledframeButtonHeight * 0.53)
                            .disableAutocorrection(true)
                        }
                        .padding(.top, scaledPadding)
                        
                        ZStack {
                            Image("PartnersChoosingButton")
                                .resizable()
                                .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight)
                                .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                            TextField(text: $partnersname.partnersname, prompt: Text("Name")) {
                                Text("Username")
                            }
                            .frame(width: scaledframeButtonWidth * 0.87, height: scaledframeButtonHeight * 0.2)
                            .font(Font.custom("PressStart2P", fixedSize: 20))
                            .foregroundColor(.brownnr2)
                            .padding(.leading, 10)
                            .padding(.top, scaledframeButtonHeight * 0.53)
                            .disableAutocorrection(true)
                        }
                        .padding(.top, scaledPadding)
                        
                        Button(action: {
                            if username.username.isEmpty || partnersname.partnersname.isEmpty || yourchoice.ychosenCat == 0 || partnerschoice.pchosenCat == 0 {
                                showError = true
                                withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                                    buttonOffset = 5
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    buttonOffset = 0
                                }
                            } else {
                                showError = false
                                showNextView = true
                            }
                        }) {
                            Image("SetButton")
                                .resizable()
                                .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                                .offset(x: buttonOffset)
                        }
                        .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight * 0.75)
                        .padding(.top, scaledPadding)
                        
                        Text("You need to fill all the fields and choose cats")
                            .font(Font.custom("PressStart2P", fixedSize: 8))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 20, alignment: .center)
                            .padding(.top, scaledPadding * 0.5)
                            .opacity(showError ? 1 : 0)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showNextView, content: {
            MainPageView(yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschoice)
        })
    }
    
    private func imageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }
}

struct ImageForCatChoice: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 160, height: 160)
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

#Preview{
    LoginView()
}

