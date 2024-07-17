//
//  PartnersCatChoosingView.swift
//  DatMemo
//
//
//
import SwiftUI


class partnerschosencat: ObservableObject {
    @Published var pchosenCat: Int8 = 0 {
        didSet {
            SettingsManager.shared.savePartnersChoice(pchosenCat)
        }
    }

    init() {
        self.pchosenCat = SettingsManager.shared.getPartnersChoice()
    }
}

struct PartnersCatChoosingView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var partnerschoice: partnerschosencat

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
                    print("Your partner's cat is ArtiomkaCat")
                    partnerschoice.pchosenCat = 1
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("artiomkaCatChoosingButton")
                        .resizable()
                        .frame(width: 165, height: 165)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }

                Button {
                    print("Your partner's cat is SashenkaCat")
                    partnerschoice.pchosenCat = 2
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("sashenkaCatChoosingButton")
                        .resizable()
                        .frame(width: 165, height: 165)
                        .shadow(color: .black, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }

                Button {
                    print("Your partner's cat is DimaCat")
                    partnerschoice.pchosenCat = 3
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("dimaCatChoosingButton")
                        .resizable()
                        .frame(width: 165, height: 165)
                        .shadow(color: .black, radius: 0, x: 6, y: 5)
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
struct PartnersCatChoosingView_Previews: PreviewProvider {
    static var previews: some View {
        PartnersCatChoosingView().environmentObject(partnerschosencat())
    }
}
