//
//  Medication.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 11/06/2026.
//

import Foundation
import SwiftData

@Model
final class Medication {
    var name: String?
    var dosage: String?
    var startDate: Date?
    var endDate: Date?
    var instructions: String?

    var pet: Pet?

    init(
        name: String? = nil,
        dosage: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        instructions: String? = nil,
        pet: Pet? = nil
    ) {
        self.name = name
        self.dosage = dosage
        self.startDate = startDate
        self.endDate = endDate
        self.instructions = instructions
        self.pet = pet
    }
}
