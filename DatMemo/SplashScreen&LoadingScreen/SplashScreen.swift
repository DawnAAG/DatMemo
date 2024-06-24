//SplashScreen
//
//
//
import SwiftUI

struct SplashScreen: View{
    @State var isActive: Bool = false
    let background = Image("Background")
    var body: some View{
        ZStack {
            
            if self.isActive {
                LoginView()
            }
            else {
                background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .imageScale(.small)
                    .containerRelativeFrame(.horizontal){
                        size, axis in size * 0.5
                    }
            }
            }
        }
        .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }

    }
}

#Preview {
    SplashScreen()
}

