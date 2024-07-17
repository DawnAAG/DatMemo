//
//  File.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 16.07.2024.
//

import Foundation

struct CompletedDate: Codable, Identifiable {
    var id = UUID()
    var date: Date
}
