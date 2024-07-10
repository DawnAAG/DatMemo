//
//  CaptureView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 10.07.2024.
//

import SwiftUI
import AVKit

struct CaptureView: View {
    let date: Date
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat
    @EnvironmentObject var photoManager: PhotoManager
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 100
    private func imageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            ZStack {
                Image("backgroundblur")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()

                VStack {
                    HStack(alignment: .center) {
                        Text(username.username)
                            .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.08 : 0.095))
                            .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 7.6 : 7.6)))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: scaledsize * (isSmallDevice ? 1.064 : 1.064), height: scaledsize * (isSmallDevice ? 0.076 : 0.076), alignment: .trailing)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)

                        Image("heart")
                            .resizable()
                            .frame(width: scaledsize * (isSmallDevice ? 0.46 : 0.6), height: scaledsize * (isSmallDevice ? 0.4 : 0.56), alignment: .center)
                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)

                        Text(partnersname.partnersname)
                            .multilineTextAlignment(.leading)
                            .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.08 : 0.095))
                            .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 7.6 : 7.6)))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: scaledsize * (isSmallDevice ? 1.064 : 1.064), height: scaledsize * (isSmallDevice ? 0.076 : 0.076), alignment: .leading)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                    }
                    .frame(width: isSmallDevice ? 432 : 432, height: isSmallDevice ? 56 : 56, alignment: .center)
                    .padding(.bottom, 10)

                    VStack(alignment: .center) {
                        ZStack {
                            Image("backfordayview")
                                .resizable()
                                .ignoresSafeArea()

                            VStack {
                                Text(date.formattedWithSuffix())
                                    .font(Font.custom("PressStart2P", size: 10))
                                    .foregroundColor(.white)
                                    .padding(.bottom, isSmallDevice ? 2 : 3)
                                    .padding(.top, isSmallDevice ? -10 : -10)

                                if let selectedPhoto = photoManager.photos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                        Image(uiImage: selectedPhoto)
                                            .resizable()
                                            .scaledToFit()
                                            .ignoresSafeArea()
                                            .frame(maxWidth: isSmallDevice ? 178 : 228, maxHeight: isSmallDevice ? 248 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else if let selectedVideo = photoManager.videos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                        VideoPlayer(player: AVPlayer(url: selectedVideo))
                                            .frame(maxWidth: isSmallDevice ? 178 : 228, maxHeight: isSmallDevice ? 238 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                        Text("Tap to choose Image or video")
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: isSmallDevice ? 10 : 12))
                                    }
                                    .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                }

                                if let text = photoManager.texts[date] {
                                    VStack {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                            Text(text)
                                                .foregroundColor(.white)
                                                .padding()
                                                .font(Font.custom("PressStart2P", size: 11.4))
                                                .cornerRadius(8)
                                                .padding()
                                        }
                                    }
                                    .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                        Text("Tap to text")
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                }
                            }
                        }
                        .frame(width: isSmallDevice ? 280 : 320, height: isSmallDevice ? 508 : 608)
                    }
                    .frame(width: isSmallDevice ? 280 : 320, height: isSmallDevice ? 508 : 608)
                    .aspectRatio(contentMode: .fill)
                    .navigationBarHidden(true)
                    
                    HStack(spacing: 100) {
                        Image(imageName(for: yourchoice.ychosenCat))
                            .resizable()
                            .frame(width: 75, height: 75)
                        
                        Image(imageName(for: partnerschosencat.pchosenCat))
                            .resizable()
                            .frame(width: 75, height: 75)
                    }
                    .padding(.top, isSmallDevice ? 5 : 10)
                }
            }
            .offset(y: isSmallDevice ? -160 : -80)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if value.startLocation.x < 20 && value.translation.width > 100 {
                    self.mode.wrappedValue.dismiss()
                }
            }))
            .frame(width: geometry.size.width)
            .aspectRatio(contentMode: .fill)
            .navigationBarHidden(true)
        }
        
    }
}

struct CaptureView_Previews: PreviewProvider {
    static var previews: some View {
        let photoManager = PhotoManager()
        CaptureView(
            date: Date(),
            yourchoice: yourchosencat(),
            username: Username(),
            partnersname: Partnersname(),
            partnerschosencat: partnerschosencat()
        )
        .environmentObject(photoManager)
    }
}
