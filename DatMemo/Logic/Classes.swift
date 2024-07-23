//
//  Classes.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 22.07.2024.
//

import Foundation

class yourchosencat: ObservableObject {
    @Published var ychosenCat: Int8 = 0 {
        didSet {
            SettingsManager.shared.saveYourChoice(ychosenCat)
        }
    }

    init() {
        self.ychosenCat = SettingsManager.shared.getYourChoice()
    }
}
class partnerschosencat: ObservableObject {
    @Published var pchosenCat: Int8 = 0 {
        didSet {
            SettingsManager.shared.savePartnersChoice(pchosenCat)
        }
    }

    init() {
        self.pchosenCat = SettingsManager.shared.getPartnersChoice()
    }
}
