import SwiftUI

import SwiftUI

class yourchosencat: ObservableObject {
    @Published var ychosenCat: Int8 = 0 {
        didSet {
            SettingsManager.shared.saveYourChoice(ychosenCat)
        }
    }

    init() {
        self.ychosenCat = SettingsManager.shared.getYourChoice()
    }
}

struct YourCatChoosingView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var yourchoice: yourchosencat

    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        ZStack {
            background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()

            VStack(alignment: .center) {
                Spacer()

                Button {
                    print("Your cat is ArtiomkaCat")
                    yourchoice.ychosenCat = 1
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("artiomkaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }

                Button {
                    print("Your cat is SashenkaCat")
                    yourchoice.ychosenCat = 2
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("sashenkaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }

                Button {
                    print("Your cat is DimaCat")
                    yourchoice.ychosenCat = 3
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("dimaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                }

                Spacer()
            }
        }
        .onAppear { AudioManager.shared.configureAudioSession() }
        .onDisappear { AudioManager.shared.deactivateAudioSession() }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

// Preview
struct YourCatChoosingView_Previews: PreviewProvider {
    static var previews: some View {
        YourCatChoosingView().environmentObject(yourchosencat())
    }
}
