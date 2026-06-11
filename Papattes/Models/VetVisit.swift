//
//  VetVisit.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 11/06/2026.
//

import Foundation
import SwiftData

@Model
final class VetVisit {
    var date: Date?
    var reason: String?
    var notes: String?

    var pet: Pet?

    init(date: Date? = nil, reason: String? = nil, notes: String? = nil, pet: Pet? = nil) {
        self.date = date
        self.reason = reason
        self.notes = notes
        self.pet = pet
    }
}
