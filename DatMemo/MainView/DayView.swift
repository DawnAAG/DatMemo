//
//  DayView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 28.06.2024.
//
import SwiftUI

struct DayView: View {
    let date: Date
    let backgroundBlur = Image("backgroundblur")
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var photoManager: PhotoManager

    @State private var selectedPhoto: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
        ZStack {
            backgroundBlur
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()

            VStack {
                if let selectedPhoto = photoManager.photos[date] {
                    Image(uiImage: selectedPhoto)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea(edges: .all)
                } else {
                    Button("Upload Photo") {
                        isImagePickerPresented = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedPhoto) { photo in
                    if let photo = photo {
                        photoManager.savePhoto(photo, for: date)
                        selectedPhoto = photo
                    }
                }
            }
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
