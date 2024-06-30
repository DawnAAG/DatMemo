//
//  DayView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 28.06.2024.
//
import SwiftUI
import AVKit

struct DayView: View {
    let date: Date
    let backgroundBlur = Image("backgroundblur")
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var photoManager: PhotoManager
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 95 // Reduced by 5%
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat

    @State private var selectedPhoto: UIImage?
    @State private var selectedVideo: URL?
    @State private var inputText: String = ""
    @State private var isImagePickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var showPhotoSourcePicker = false
    @State private var showTextEditor = false

    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            NavigationView {
                ZStack {
                    backgroundBlur
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    VStack {
                        HStack {
                            CustomBackButton1 {
                                self.mode.wrappedValue.dismiss()
                            }
                            .padding(.trailing, isSmallDevice ? 285 : 304)
                        }
                        .frame(height: 42)

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
                        .frame(width: scaledsize * 2.926, height: scaledsize * 0.56, alignment: .center)
                        .padding(.bottom, isSmallDevice ? 10 : 10)
                        .padding(.top, isSmallDevice ? -10 : -45)
                        ZStack {
                            Image("backfordayview")
                                .resizable()
                                .ignoresSafeArea()
                            VStack {
                                if let selectedPhoto = photoManager.photos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                        Image(uiImage: selectedPhoto)
                                            .resizable()
                                            .scaledToFit()
                                            .ignoresSafeArea()
                                            .frame(maxWidth: isSmallDevice ? 228 : 228, maxHeight: isSmallDevice ? 288 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else if let selectedVideo = photoManager.videos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                        VideoPlayer(player: AVPlayer(url: selectedVideo))
                                            .frame(maxWidth: isSmallDevice ? 228 : 228, maxHeight: isSmallDevice ? 288 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                        Button("Tap to choose Image or video") {
                                            showPhotoSourcePicker = true
                                        }
                                        .foregroundColor(.white)
                                        .font(Font.custom("PressStart2P", size: 10))
                                        .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                    }
                                    .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                }

                                if let text = photoManager.texts[date] {
                                    VStack {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
                                            VStack {
                                                Text(text)
                                                    .foregroundStyle(Color.white)
                                                    .padding()
                                                    .font(Font.custom("PressStart2P", size: 11.4))
                                                    .cornerRadius(8)
                                                    .padding()
                                            }
                                        }
                                        .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
                                        Button("Edit Text") {
                                            inputText = text
                                            showTextEditor = true
                                        }
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .font(Font.custom("PressStart2P", size: 8))
                                    }
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .scaledToFit()
                                        Button("Tap to text") {
                                            showTextEditor = true
                                        }
                                        .padding()
                                        .foregroundColor(.white)
                                        .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
                                }
                            }
                            .actionSheet(isPresented: $showPhotoSourcePicker) {
                                ActionSheet(title: Text("Select Photo or Video Source"), message: nil, buttons: [
                                    .default(Text("Camera")) {
                                        isCameraPickerPresented = true
                                    },
                                    .default(Text("Photo Library")) {
                                        isImagePickerPresented = true
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $isImagePickerPresented) {
                                ImagePicker(image: $selectedPhoto, videoURL: $selectedVideo, sourceType: .photoLibrary, mediaTypes: ["public.image", "public.movie"]) { photo, video in
                                    if let photo = photo {
                                        photoManager.savePhoto(photo, for: date)
                                        selectedPhoto = photo
                                    } else if let video = video {
                                        photoManager.saveVideo(video, for: date)
                                        selectedVideo = video
                                    }
                                }
                            }
                            .sheet(isPresented: $isCameraPickerPresented) {
                                ImagePicker(image: $selectedPhoto, videoURL: $selectedVideo, sourceType: .camera, mediaTypes: ["public.image", "public.movie"]) { photo, video in
                                    if let photo = photo {
                                        photoManager.savePhoto(photo, for: date)
                                        selectedPhoto = photo
                                    } else if let video = video {
                                        photoManager.saveVideo(video, for: date)
                                        selectedVideo = video
                                    }
                                }
                            }
                            .sheet(isPresented: $showTextEditor) {
                                TextEditorView(text: $inputText) { text in
                                    if text.count <= 200 {
                                        photoManager.saveText(text, for: date)
                                        inputText = text
                                        showTextEditor = false
                                    }
                                }
                            }
                        }
                        .frame(width: isSmallDevice ? 300 : 300, height: isSmallDevice ? 608 : 608)
                        .padding(.bottom, isSmallDevice ? 19 : 38)
                    }
                    .frame(width: geometry.size.width)
                    .aspectRatio(contentMode: .fill)
                    .navigationBarHidden(true)
                    .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                        if value.startLocation.x < 20 && value.translation.width > 100 {
                            self.mode.wrappedValue.dismiss()
                        }
                    }))
                }
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
}

#Preview {
    DayView(date: Date(), yourchoice: yourchosencat(), username: Username(), partnersname: Partnersname(), partnerschosencat: partnerschosencat())
        .environmentObject(PhotoManager())
}
