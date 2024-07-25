//
//  AudioManager.swift
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
            // Set the audio session category, mode, and options
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowBluetooth, .allowAirPlay])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
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

    func observeInterruptions() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption(notification:)), name: AVAudioSession.interruptionNotification, object: nil)
    }

    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }

        switch type {
        case .began:
            print("Audio session interruption began.")
            // Handle interruption started (e.g., pause audio playback)
        case .ended:
            print("Audio session interruption ended.")
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Resume playback if necessary
                    print("Resuming audio session after interruption.")
                }
            }
        @unknown default:
            break
        }
    }

    func observeRouteChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRouteChange(notification:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }

    @objc private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }

        switch reason {
        case .newDeviceAvailable:
            print("New audio device available.")
        case .oldDeviceUnavailable:
            print("Old audio device unavailable.")
        case .categoryChange:
            print("Audio session category changed.")
        default:
            break
        }
    }
}
