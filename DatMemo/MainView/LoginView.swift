import SwiftUI

// Enum for padding sides
enum Side: Equatable, Hashable {
    case left
    case right
}

// Extension to add padding with specific sides
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

// ObservableObject for Username
class Username: ObservableObject {
    private let usernameKey = "username"
    
    @Published var username: String {
        didSet {
            if username.count > 9 {
                username = String(username.prefix(9))
            }
            UserDefaults.standard.set(username, forKey: usernameKey)
        }
    }
    
    init() {
        self.username = UserDefaults.standard.string(forKey: usernameKey) ?? ""
    }
}
// ObservableObject for Partnersname
import SwiftUI

class Partnersname: ObservableObject {
    private let partnersnameKey = "partnersname"
    
    @Published var partnersname: String {
        didSet {
            if partnersname.count > 9 {
                partnersname = String(partnersname.prefix(9))
            }
            UserDefaults.standard.set(partnersname, forKey: partnersnameKey)
        }
    }
    
    init() {
        self.partnersname = UserDefaults.standard.string(forKey: partnersnameKey) ?? ""
    }
}


// Main LoginView struct
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
    @ObservedObject var usernameObj = Username()
    @ObservedObject var partnersnameObj = Partnersname()
    
    @State private var showError = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var showNextView = false
    
    // UserDefaults keys
    private let yourChoiceKey = "yourChoice"
    private let partnersChoiceKey = "partnersChoice"
    private let loggedInKey = "loggedIn"
    private let usernameKey = "username" // Added for clarity and usage
    private let partnersnameKey = "partnersname" // Added for clarity and usage
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                if showNextView {
                    MainPageView(yourchoice: yourchoice, username: usernameObj, partnersname: partnersnameObj, partnerschosencat: partnerschoice)
                        .transition(.opacity)
                } else {
                    loginContentView
                }
            }
        }
        .onAppear {
            // Check if already logged in
            if UserDefaults.standard.bool(forKey: loggedInKey) {
                // Load data from UserDefaults
                if let savedYourChoice = UserDefaults.standard.object(forKey: yourChoiceKey) as? Int {
                    yourchoice.ychosenCat = Int8(savedYourChoice)
                }
                if let savedPartnersChoice = UserDefaults.standard.object(forKey: partnersChoiceKey) as? Int {
                    partnerschoice.pchosenCat = Int8(savedPartnersChoice)
                }
                
                // Navigate to main page
                showNextView = true
            }
        }
    }
    
    private var loginContentView: some View {
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
                    TextField("Name", text: $usernameObj.username)
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
                    TextField("Name", text: $partnersnameObj.partnersname)
                        .frame(width: scaledframeButtonWidth * 0.87, height: scaledframeButtonHeight * 0.2)
                        .font(Font.custom("PressStart2P", fixedSize: 20))
                        .foregroundColor(.brownnr2)
                        .padding(.leading, 10)
                        .padding(.top, scaledframeButtonHeight * 0.53)
                        .disableAutocorrection(true)
                }
                .padding(.top, scaledPadding)
                
                Button(action: {
                    if usernameObj.username.isEmpty || partnersnameObj.partnersname.isEmpty || yourchoice.ychosenCat == 0 || partnerschoice.pchosenCat == 0 {
                        showError = true
                        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                            buttonOffset = 5
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            buttonOffset = 0
                        }
                    } else {
                        showError = false
                        
                        // Save data to UserDefaults
                        UserDefaults.standard.set(usernameObj.username, forKey: usernameKey)
                        UserDefaults.standard.set(partnersnameObj.partnersname, forKey: partnersnameKey)
                        UserDefaults.standard.set(Int(yourchoice.ychosenCat), forKey: yourChoiceKey)
                        UserDefaults.standard.set(Int(partnerschoice.pchosenCat), forKey: partnersChoiceKey)
                        
                        // Mark as logged in
                        UserDefaults.standard.set(true, forKey: loggedInKey)
                        
                        // Navigate to main page
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
    
    private func imageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }
}

// ImageForCatChoice view struct
struct ImageForCatChoice: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
    }
}

// Preview for LoginView
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
