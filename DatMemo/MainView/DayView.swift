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

    @State private var selectedPhoto: UIImage?
    @State private var selectedVideo: URL?
    @State private var inputText: String = ""
    @State private var isImagePickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var showPhotoSourcePicker = false
    @State private var showTextEditor = false
    
    var body: some View {
        ZStack {
            backgroundBlur
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
//            HStack(alignment: .center) {
//                Text(username.username)
//                    .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.085 : 0.1))
//                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 8 : 8)))
//                    .foregroundColor(Color.brownnr2)
//                    .frame(width: scaledsize * (isSmallDevice ? 1.12 : 1.12), height: scaledsize * (isSmallDevice ? 0.08 : 0.08), alignment: .trailing)
//                    .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
//                
//                Image("heart")
//                    .resizable()
//                    .frame(width: scaledsize * (isSmallDevice ? 0.49 : 0.64), height: scaledsize * (isSmallDevice ? 0.44 : 0.59), alignment: .center)
//                    .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
//                
//                Text(partnersname.partnersname)
//                    .multilineTextAlignment(.leading)
//                    .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.085 : 0.1))
//                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 8 : 8)))
//                    .foregroundColor(Color.brownnr2)
//                    .frame(width: scaledsize * (isSmallDevice ? 1.12 : 1.12), height: scaledsize * (isSmallDevice ? 0.08 : 0.08), alignment: .leading)
//                    .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
//            }
//            .frame(width: scaledsize * 3.08, height: scaledsize * 0.59, alignment: .center)
//            .padding(.top, scaledsize * (isSmallDevice ? 0.1 : 0.44))
            
            //I NEED TO ADD THIS

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
                                .frame(width:250, height:314)
                            Image(uiImage: selectedPhoto)
                                .resizable()
                                .scaledToFit()
                                .ignoresSafeArea()
                                .frame(maxWidth: 240, maxHeight: 304)
                                .aspectRatio(contentMode: .fit)
                        }
                    } else if let selectedVideo = photoManager.videos[date] {
                        ZStack {
                            Image("textblock")
                                .resizable()
                                .ignoresSafeArea()
                                .frame(width:250, height:314)
                            VideoPlayer(player: AVPlayer(url: selectedVideo))
                                .frame(maxWidth: 240, maxHeight: 304)
                                .aspectRatio(contentMode: .fit)
                        }
                    } else {
                        ZStack {
                            Image("textblock")
                                .resizable()
                                .ignoresSafeArea()
                                .frame(width:250, height:314)
                            Button("Tap to choose Image or video") {
                                showPhotoSourcePicker = true
                            }
                            //ADD THE FUCKING STYLING HERE
                            .foregroundColor(.white)
                            .font(Font.custom("PressStart2P",size: 10))
                            .frame(width:250, height:314)
                        }
                        .frame(width:250, height:314)
                    }
                    
                    if let text = photoManager.texts[date] {
                        VStack {
                            ZStack {
                                Image("textblock")
                                    .resizable()
                                    .ignoresSafeArea()
                                    .frame(width:280, height:250)
                                VStack {
                                    Text(text)
                                    //ADD THE FUCKING STYLING HERE
                                        .foregroundStyle(Color.white)
                                        .padding()
                                        .font(Font.custom("PressStart2P", size: 12))
                                        .cornerRadius(8)
                                        .padding()
                                }
                            }
                            .frame(width:280, height:250)
                            Button("Edit Text") {
                                inputText = text
                                showTextEditor = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(Font.custom("PressStart2P",size: 8))
                            .cornerRadius(8)
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
                            .font(Font.custom("PressStart2P",size: 10))
                        .cornerRadius(8)
                        }
                        .frame(width:280, height:250)
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
            .frame(width:350, height: 640)
        }
        .navigationBarHidden(true)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(date: Date())
            .environmentObject(PhotoManager())
    }
}
