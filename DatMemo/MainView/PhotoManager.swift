//
//  PhotoManager.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 28.06.2024.
//
import SwiftUI
import Combine

class PhotoManager: ObservableObject {
    @Published var photos: [Date: UIImage] = [:]
    
    func savePhoto(_ photo: UIImage, for date: Date) {
        photos[date] = photo
        // Save the photo to persistent storage
        savePhotosToDisk()
    }
    
    func loadPhotos() {
        // Load photos from persistent storage
        loadPhotosFromDisk()
    }
    
    private func savePhotosToDisk() {
        // Implement saving to persistent storage, e.g., UserDefaults, file system, CoreData, etc.
    }
    
    private func loadPhotosFromDisk() {
        // Implement loading from persistent storage
    }
}

