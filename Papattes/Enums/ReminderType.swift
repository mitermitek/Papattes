//
//  ReminderType.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

enum ReminderType: String, Codable, CaseIterable {
    case vaccine
    case medication
    case grooming
    case vetVisit
    case feeding
    case custom

    var label: String {
        switch self {
        case .vaccine: "Vaccin"
        case .medication: "Médicament"
        case .grooming: "Toilettage"
        case .vetVisit: "Visite vétérinaire"
        case .feeding: "Alimentation"
        case .custom: "Personnalisé"
        }
    }
}
