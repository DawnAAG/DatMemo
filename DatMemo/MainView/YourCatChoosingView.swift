import SwiftUI

class yourchosencat: ObservableObject {
    @Published var ychosenCat: Int8 = 0
}


struct YourCatChoosingView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var yourchoice: yourchosencat

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
                    print("Your cat is ArtiomkaCat")
                    yourchoice.ychosenCat = 1
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("artiomkaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x :6, y: 5)
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
    YourCatChoosingView().environmentObject(yourchosencat())
}

