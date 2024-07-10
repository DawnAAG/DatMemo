//
//  DatMemoApp.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 24.04.2024.
//

import SwiftUI
import SwiftData

@main
struct DatMemoApp: App {
    @StateObject private var photoManager = PhotoManager()
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(photoManager)
        }
    }
}
