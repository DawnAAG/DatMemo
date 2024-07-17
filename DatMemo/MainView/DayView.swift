//
//  DayView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 28.06.2024.
//
import SwiftUI
import Foundation

extension Date {
    func formattedWithSuffix() -> String {
        let day = Calendar.current.component(.day, from: self)
        let dayFormatter = NumberFormatter()
        dayFormatter.numberStyle = .ordinal
        let dayString = dayFormatter.string(from: NSNumber(value: day)) ?? "\(day)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: self)
        return "The \(dayString) of \(monthString)"
    }
}

struct DayView: View {
    let date: Date
    let backgroundBlur = Image("backgroundblur")
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var photoManager: PhotoManager
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 95
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat

    @State private var isNavigationActive = false
    @State private var selectedPhoto: UIImage?
    @State private var inputText: String = ""
    @State private var isImagePickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var showPhotoSourcePicker = false
    @State private var showTextEditor = false
    @State private var showAlert = false
    @State private var showIncompleteAlert = false
    @State private var showConfirmationAlert = false
    @State private var contentSaved = false

    var onSaveContent: ((Date) -> Void)?

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isSmallDevice = geometry.size.height < 667
                ZStack {
                    backgroundBlur
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    VStack {
                        HStack {
                            CustomBackButton1 {
                                if contentSaved {
                                    self.mode.wrappedValue.dismiss()
                                } else {
                                    showConfirmationAlert = true
                                }
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
                        VStack(alignment: .center) {
                            ZStack {
                                Image("backfordayview")
                                    .resizable()
                                    .ignoresSafeArea()
                                VStack {
                                    Text(date.formattedWithSuffix())
                                        .font(Font.custom("PressStart2P", fixedSize: 10))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 2)
                                        .padding(.top, -10)
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
                                                .onTapGesture {
                                                    showPhotoSourcePicker = true
                                                }
                                        }
                                    } else {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                            Button("Tap to choose Image") {
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
                                                        .onTapGesture {
                                                            inputText = text
                                                            showTextEditor = true
                                                        }
                                                }
                                            }
                                            .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
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
                                    ActionSheet(title: Text("Select Photo Source"), message: nil, buttons: [
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
                                    ImagePicker(image: $selectedPhoto, sourceType: .photoLibrary, mediaTypes: ["public.image"]) { photo in
                                        if let photo = photo {
                                            photoManager.savePhoto(photo, for: date)
                                            selectedPhoto = photo
                                            contentSaved = true
                                        }
                                    }
                                }
                                .sheet(isPresented: $isCameraPickerPresented) {
                                    ImagePicker(image: $selectedPhoto, sourceType: .camera, mediaTypes: ["public.image"]) { photo in
                                        if let photo = photo {
                                            photoManager.savePhoto(photo, for: date)
                                            selectedPhoto = photo
                                            contentSaved = true
                                        }
                                    }
                                }
                                .sheet(isPresented: $showTextEditor) {
                                    TextEditorView(text: $inputText) { text in
                                        if text.count <= 200 {
                                            photoManager.saveText(text, for: date)
                                            inputText = text
                                            contentSaved = true
                                            showTextEditor = false
                                        }
                                    }
                                }
                            }
                            .frame(width: isSmallDevice ? 300 : 320, height: isSmallDevice ? 608 : 608)
                        }
                        Button(action: {
                            if let _ = photoManager.photos[date], let savedText = photoManager.texts[date], !savedText.isEmpty {
                                contentSaved = true
                                onSaveContent?(date)
                                isNavigationActive = true
                            } else {
                                showIncompleteAlert = true
                            }
                        }) {
                            Image("sendbutton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: isSmallDevice ? 250 : 250, height: isSmallDevice ? 75 : 75)
                        }
                        .navigationDestination(isPresented: $isNavigationActive) {
                                                   PreviewSendView(date: date, yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)
                                                       .environmentObject(photoManager)
                                               }

                        .alert(isPresented: $showIncompleteAlert) {
                            Alert(
                                title: Text("Incomplete Content"),
                                message: Text("Please ensure both a photo and some text are added."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                }
                .offset(y: -50)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            if value.translation.width > 100 {
                                if contentSaved {
                                    self.mode.wrappedValue.dismiss()
                                } else {
                                    showConfirmationAlert = true
                                }
                            }
                        }
                )
                .alert(isPresented: $showConfirmationAlert) {
                    Alert(
                        title: Text("Unsaved Changes"),
                        message: Text("You have unsaved changes. Do you want to discard them and leave?"),
                        primaryButton: .destructive(Text("Discard")) {
                            self.mode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            // Check if there's any saved content
            if let _ = photoManager.photos[date], let savedText = photoManager.texts[date], !savedText.isEmpty {
                contentSaved = true
            }
        }
    }
}


struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        let yourchoice = yourchosencat()
        let username = Username()
        let partnersname = Partnersname()
        let partnerschosencat = partnerschosencat()
        
        return DayView(date: date, yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)
            .environmentObject(PhotoManager())
    }
}
