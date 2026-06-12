//
//  RemindersFormView.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 12/06/2026.
//

import SwiftData
import SwiftUI

struct RemindersFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Pet.name) private var pets: [Pet]

    var reminderToEdit: Reminder?

    @State private var title = ""
    @State private var date = Date()
    @State private var type: ReminderType = .custom
    @State private var notes = ""
    @State private var selectedPet: Pet?

    init(reminderToEdit: Reminder? = nil) {
        self.reminderToEdit = reminderToEdit

        if let reminder = reminderToEdit {
            _title = State(initialValue: reminder.title ?? "")
            _date = State(initialValue: reminder.date ?? Date())
            _type = State(initialValue: reminder.type ?? .custom)
            _notes = State(initialValue: reminder.notes ?? "")
            _selectedPet = State(initialValue: reminder.pet)
        } else {
            _title = State(initialValue: "")
            _date = State(initialValue: Date())
            _type = State(initialValue: .custom)
            _notes = State(initialValue: "")
            _selectedPet = State(initialValue: nil)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Informations") {
                    TextField("Titre", text: $title)

                    Picker("Type", selection: $type) {
                        ForEach(ReminderType.allCases, id: \.self) { type in
                            Text(type.label)
                                .tag(type)
                        }
                    }

                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )

                    if !pets.isEmpty {
                        Picker("Animal", selection: $selectedPet) {
                            Text("Aucun animal")
                                .tag(Optional<Pet>.none)

                            ForEach(pets, id: \.persistentModelID) { pet in
                                Text(pet.name ?? "Animal")
                                    .tag(Optional(pet))
                            }
                        }
                    }
                }

                Section("Notes") {
                    TextField(
                        "Notes",
                        text: $notes,
                        axis: .vertical
                    )
                    .lineLimit(4...8)
                }
            }
            .navigationTitle("Rappel")
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
                        if let reminderToEdit {
                            reminderToEdit.title = title.isEmpty ? nil : title
                            reminderToEdit.date = date
                            reminderToEdit.type = type
                            reminderToEdit.notes = notes.isEmpty ? nil : notes
                            reminderToEdit.pet = selectedPet
                        } else {
                            let reminder = Reminder(
                                title: title.isEmpty ? nil : title,
                                date: date,
                                type: type,
                                notes: notes.isEmpty ? nil : notes,
                                pet: selectedPet
                            )

                            modelContext.insert(reminder)
                        }

                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Failed to save reminder: \(error.localizedDescription)")
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .accessibilityLabel("Enregistrer")
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines)
                            .isEmpty
                    )
                }
            }
        }
    }
}
