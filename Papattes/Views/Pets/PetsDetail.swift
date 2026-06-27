//
//  PetsDetail.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 27/06/2026.
//

import SwiftUI
import SwiftData

struct PetsDetailView: View {
    let pet: Pet
    let onEdit: () -> Void

    var body: some View {
        Form {
            Section("Informations") {
                LabeledContent("Nom", value: pet.name ?? "-")

                LabeledContent("Espèce", value: pet.species?.label ?? "-")

                LabeledContent("Sexe", value: pet.sex?.label ?? "-")

                if let birthDate = pet.birthDate {
                    LabeledContent {
                        Text(birthDate, format: .dateTime)
                    } label: {
                        Text("Date de naissance")
                    }
                }
            }

            Section("Résumé") {
                LabeledContent("Rappels", value: String(pet.reminders.count))
                LabeledContent("Vaccins", value: String(pet.vaccines.count))
                LabeledContent("Médicaments", value: String(pet.medications.count))
                LabeledContent("Visites vétérinaires", value: String(pet.vetVisits.count))
                LabeledContent("Poids", value: String(pet.weightEntries.count))
            }
        }
        .navigationTitle(pet.name ?? "Animal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Modifier") {
                    onEdit()
                }
            }
        }
    }
}
