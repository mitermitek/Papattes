//
//  Species.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

enum Species: String, Codable, CaseIterable {
    case dog
    case cat
    case rabbit
    case bird
    case fish
    case reptile
    case other

    var label: String {
        switch self {
        case .dog: "Chien"
        case .cat: "Chat"
        case .rabbit: "Lapin"
        case .bird: "Oiseau"
        case .fish: "Poisson"
        case .reptile: "Reptile"
        case .other: "Autre"
        }
    }
}
