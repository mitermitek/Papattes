//
//  PetsFormView.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 27/06/2026.
//

import SwiftUI
import SwiftData

struct PetsFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var petToEdit: Pet?

    @State private var name = ""
    @State private var species: Species = .other
    @State private var sex: Sex = .male
    @State private var birthDate = Date()
    @State private var hasBirthDate = false

    init(petToEdit: Pet? = nil) {
        self.petToEdit = petToEdit

        if let pet = petToEdit {
            _name = State(initialValue: pet.name ?? "")
            _species = State(initialValue: pet.species ?? .other)
            _sex = State(initialValue: pet.sex ?? .male)
            _birthDate = State(initialValue: pet.birthDate ?? Date())
            _hasBirthDate = State(initialValue: pet.birthDate != nil)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Informations") {
                    TextField("Nom", text: $name)

                    Picker("Espèce", selection: $species) {
                        ForEach(Species.allCases, id: \.self) { species in
                            Text(species.label).tag(species)
                        }
                    }

                    Picker("Sexe", selection: $sex) {
                        ForEach(Sex.allCases, id: \.self) { sex in
                            Text(sex.label).tag(sex)
                        }
                    }

                    Toggle("Date de naissance", isOn: $hasBirthDate)

                    if hasBirthDate {
                        DatePicker(
                            "Date de naissance",
                            selection: $birthDate,
                            displayedComponents: [.date]
                        )
                    }
                }
            }
            .navigationTitle(petToEdit == nil ? "Nouvel animal" : "Modifier l’animal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Annuler")
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let formattedBirthDate = hasBirthDate ? Calendar.current.startOfDay(for: birthDate) : nil

                        if let petToEdit {
                            petToEdit.name = name.isEmpty ? nil : name
                            petToEdit.species = species
                            petToEdit.sex = sex
                            petToEdit.birthDate = formattedBirthDate
                        } else {
                            let pet = Pet(
                                name: name.isEmpty ? nil : name,
                                species: species,
                                sex: sex,
                                birthDate: formattedBirthDate
                            )
                            
                            modelContext.insert(pet)
                        }

                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Failed to save pet: \(error.localizedDescription)")
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .accessibilityLabel("Enregistrer")
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
