//
//  Vaccine.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class Vaccine {
    var name: String?
    var administeredAt: Date?
    var notes: String?

    var pet: Pet?

    init(
        name: String? = nil,
        administeredAt: Date? = nil,
        notes: String? = nil,
        pet: Pet? = nil
    ) {
        self.name = name
        self.administeredAt = administeredAt
        self.notes = notes
        self.pet = pet
    }
}
