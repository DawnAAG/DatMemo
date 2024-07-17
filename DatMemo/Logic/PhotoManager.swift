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
    @Published var texts: [Date: String] = [:]

    private let photosDirectoryName = "Photos"
    private let textsDirectoryName = "Texts"
    private let fileExtension = "json"

    init() {
        loadPhotos()
        loadTexts()
    }

    func savePhoto(_ photo: UIImage, for date: Date) {
        photos[date] = photo
        savePhotosToDisk()
    }

    func saveText(_ text: String, for date: Date) {
        texts[date] = text
        saveTextsToDisk()
    }

    func loadPhotos() {
        loadPhotosFromDisk()
    }

    func loadTexts() {
        loadTextsFromDisk()
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    private func getPhotosDirectoryURL() -> URL {
        getDocumentsDirectory().appendingPathComponent(photosDirectoryName, isDirectory: true)
    }

    private func getTextsDirectoryURL() -> URL {
        getDocumentsDirectory().appendingPathComponent(textsDirectoryName, isDirectory: true)
    }

    private func savePhotosToDisk() {
        let photosURL = getPhotosDirectoryURL().appendingPathComponent("\(photosDirectoryName).\(fileExtension)")

        do {
            try FileManager.default.createDirectory(at: getPhotosDirectoryURL(), withIntermediateDirectories: true, attributes: nil)
            let data = try JSONEncoder().encode(photos.mapValues { $0.pngData() })
            try data.write(to: photosURL)
        } catch {
            print("Error saving photos to disk: \(error.localizedDescription)")
        }
    }

    private func saveTextsToDisk() {
        let textsURL = getTextsDirectoryURL().appendingPathComponent("\(textsDirectoryName).\(fileExtension)")

        do {
            try FileManager.default.createDirectory(at: getTextsDirectoryURL(), withIntermediateDirectories: true, attributes: nil)
            let data = try JSONEncoder().encode(texts)
            try data.write(to: textsURL)
        } catch {
            print("Error saving texts to disk: \(error.localizedDescription)")
        }
    }

    private func loadPhotosFromDisk() {
        let photosURL = getPhotosDirectoryURL().appendingPathComponent("\(photosDirectoryName).\(fileExtension)")

        do {
            let data = try Data(contentsOf: photosURL)
            let decodedPhotos = try JSONDecoder().decode([Date: Data].self, from: data)
            photos = decodedPhotos.mapValues { UIImage(data: $0)! }
        } catch {
            print("Error loading photos from disk: \(error.localizedDescription)")
        }
    }

    private func loadTextsFromDisk() {
        let textsURL = getTextsDirectoryURL().appendingPathComponent("\(textsDirectoryName).\(fileExtension)")

        do {
            let data = try Data(contentsOf: textsURL)
            texts = try JSONDecoder().decode([Date: String].self, from: data)
        } catch {
            print("Error loading texts from disk: \(error.localizedDescription)")
        }
    }
}
