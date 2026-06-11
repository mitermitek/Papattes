//
//  Pet.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String?
    var species: Species?
    var sex: Sex?
    var birthDate: Date?

    @Relationship(deleteRule: .cascade, inverse: \Vaccine.pet)
    var vaccines: [Vaccine] = []

    @Relationship(deleteRule: .cascade, inverse: \Reminder.pet)
    var reminders: [Reminder] = []

    @Relationship(deleteRule: .cascade, inverse: \WeightEntry.pet)
    var weightEntries: [WeightEntry] = []

    @Relationship(deleteRule: .cascade, inverse: \VetVisit.pet)
    var vetVisits: [VetVisit] = []

    @Relationship(deleteRule: .cascade, inverse: \Medication.pet)
    var medications: [Medication] = []

    init(
        name: String? = nil,
        species: Species? = nil,
        sex: Sex? = nil,
        birthDate: Date? = nil,
        vaccines: [Vaccine] = [],
        reminders: [Reminder] = [],
        weightEntries: [WeightEntry] = [],
        vetVisits: [VetVisit] = [],
        medications: [Medication] = []
    ) {
        self.name = name
        self.species = species
        self.sex = sex
        self.birthDate = birthDate
        self.vaccines = vaccines
        self.reminders = reminders
        self.weightEntries = weightEntries
        self.vetVisits = vetVisits
        self.medications = medications
    }
}
