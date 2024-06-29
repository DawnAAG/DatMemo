//
//  PhotoManager.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 28.06.2024.
//
import SwiftUI
import Combine
import AVFoundation

class PhotoManager: ObservableObject {
    @Published var photos: [Date: UIImage] = [:]
    @Published var videos: [Date: URL] = [:]
    @Published var texts: [Date: String] = [:]
    
    func savePhoto(_ photo: UIImage, for date: Date) {
        photos[date] = photo
        // Save the photo to persistent storage
        savePhotosToDisk()
    }

    func saveVideo(_ video: URL, for date: Date) {
        videos[date] = video
        // Save the video to persistent storage
        saveVideosToDisk()
    }
    
    func saveText(_ text: String, for date: Date) {
        texts[date] = text
        // Save the text to persistent storage
        saveTextsToDisk()
    }
    
    func loadPhotos() {
        // Load photos from persistent storage
        loadPhotosFromDisk()
    }

    func loadVideos() {
        // Load videos from persistent storage
        loadVideosFromDisk()
    }

    func loadTexts() {
        // Load texts from persistent storage
        loadTextsFromDisk()
    }
    
    private func savePhotosToDisk() {
        // Implement saving photos to persistent storage, e.g., UserDefaults, file system, CoreData, etc.
    }
    
    private func saveVideosToDisk() {
        // Implement saving videos to persistent storage
    }

    private func saveTextsToDisk() {
        // Implement saving texts to persistent storage
    }
    
    private func loadPhotosFromDisk() {
        // Implement loading photos from persistent storage
    }

    private func loadVideosFromDisk() {
        // Implement loading videos from persistent storage
    }

    private func loadTextsFromDisk() {
        // Implement loading texts from persistent storage
    }
}


