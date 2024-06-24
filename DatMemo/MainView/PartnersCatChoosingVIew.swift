//
//  PartnersCatChoosingView.swift
//  DatMemo
//
//
//
import SwiftUI

class partnerschosencat: ObservableObject {
    @Published var pchosenCat: Int8 = 0
}

struct PartnersCatChoosingView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var partnerschoice: partnerschosencat

    var body: some View {
        ZStack {
            background
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
            
            VStack(alignment: .center) {
                Button {
                    print("Your partners cat is ArtiomkaCat")
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
                    print("Your partners cat is SashenkaCat")
                    partnerschoice.pchosenCat = 2
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("sashenkaCatChoosingButton")
                        .resizable()
                        .frame(width: 165, height: 165)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }
                
                Button {
                    print("Your partners cat is DimaCat")
                    partnerschoice.pchosenCat = 3
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("dimaCatChoosingButton")
                        .resizable()
                        .frame(width: 165, height: 165)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                }
            }
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

#Preview {
    PartnersCatChoosingView().environmentObject(partnerschosencat())
}
