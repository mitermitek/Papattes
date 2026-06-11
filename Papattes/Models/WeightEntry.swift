//
//  WeightEntry.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class WeightEntry {
    var weight: Double?
    var recordedAt: Date?

    var pet: Pet?

    init(weight: Double? = nil, recordedAt: Date? = nil, pet: Pet? = nil) {
        self.weight = weight
        self.recordedAt = recordedAt
        self.pet = pet
    }
}
