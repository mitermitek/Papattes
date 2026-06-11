//
//  Reminder.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class Reminder {
    var title: String?
    var date: Date?
    var type: ReminderType?
    var completedAt: Date?
    var notes: String?

    var pet: Pet?

    init(
        title: String? = nil,
        date: Date? = nil,
        type: ReminderType? = nil,
        completedAt: Date? = nil,
        notes: String? = nil,
        pet: Pet? = nil
    ) {
        self.title = title
        self.date = date
        self.type = type
        self.completedAt = completedAt
        self.notes = notes
        self.pet = pet
    }
}
