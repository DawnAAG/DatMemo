//
//  audiomanager.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 16.07.2024.
//

import AVFoundation

class AudioManager {
    static let shared = AudioManager()

    private init() {}

    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
            print("Audio session configured and activated.")
        } catch {
            print("Failed to configure and activate audio session: \(error.localizedDescription)")
        }
    }

    func deactivateAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
            print("Audio session deactivated.")
        } catch {
            print("Failed to deactivate audio session: \(error.localizedDescription)")
        }
    }
}
