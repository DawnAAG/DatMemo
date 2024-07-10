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
    @Published var videos: [Date: URL] = [:]
    @Published var texts: [Date: String] = [:]

    private let photosKey = "photosKey"
    private let videosKey = "videosKey"
    private let textsKey = "textsKey"

    init() {
        loadPhotos()
        loadVideos()
        loadTexts()
    }

    func savePhoto(_ photo: UIImage, for date: Date) {
        photos[date] = photo
        savePhotosToDisk()
    }

    func saveVideo(_ video: URL, for date: Date) {
        videos[date] = video
        saveVideosToDisk()
    }

    func saveText(_ text: String, for date: Date) {
        texts[date] = text
        saveTextsToDisk()
    }

    func loadPhotos() {
        loadPhotosFromDisk()
    }

    func loadVideos() {
        loadVideosFromDisk()
    }

    func loadTexts() {
        loadTextsFromDisk()
    }

    private func savePhotosToDisk() {
        let photoData = photos.mapValues { $0.pngData() }
        if let data = try? JSONEncoder().encode(photoData) {
            UserDefaults.standard.set(data, forKey: photosKey)
        }
    }

    private func saveVideosToDisk() {
        let videoData = videos.mapValues { $0.absoluteString }
        if let data = try? JSONEncoder().encode(videoData) {
            UserDefaults.standard.set(data, forKey: videosKey)
        }
    }

    private func saveTextsToDisk() {
        if let data = try? JSONEncoder().encode(texts) {
            UserDefaults.standard.set(data, forKey: textsKey)
        }
    }

    private func loadPhotosFromDisk() {
        if let data = UserDefaults.standard.data(forKey: photosKey),
           let photoData = try? JSONDecoder().decode([Date: Data].self, from: data) {
            photos = photoData.compactMapValues { UIImage(data: $0) }
        }
    }

    private func loadVideosFromDisk() {
        if let data = UserDefaults.standard.data(forKey: videosKey),
           let videoData = try? JSONDecoder().decode([Date: String].self, from: data) {
            videos = videoData.compactMapValues { URL(string: $0) }
        }
    }

    private func loadTextsFromDisk() {
        if let data = UserDefaults.standard.data(forKey: textsKey),
           let loadedTexts = try? JSONDecoder().decode([Date: String].self, from: data) {
            texts = loadedTexts
        }
    }
}
