//
//  Sex.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

enum Sex: String, Codable, CaseIterable {
    case male
    case female

    var label: String {
        switch self {
        case .male: "Mâle"
        case .female: "Femelle"
        }
    }
}
