//
//  RemindersDetailView.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 12/06/2026.
//

import SwiftUI

struct RemindersDetailView: View {
    let reminder: Reminder
    let onEdit: () -> Void

    var body: some View {
        Form {
            Section("Informations") {
                LabeledContent(
                    "Titre",
                    value: reminder.title ?? "-"
                )

                LabeledContent(
                    "Type",
                    value: reminder.type?.label ?? "-"
                )

                if let date = reminder.date {
                    LabeledContent {
                        Text(date, format: .dateTime)
                    } label: {
                        Text("Date")
                    }
                }
            }

            if let notes = reminder.notes,
                !notes.isEmpty
            {
                Section("Notes") {
                    Text(notes)
                }
            }

            if let completedAt = reminder.completedAt {
                Section("Statut") {
                    LabeledContent {
                        Text(completedAt, format: .dateTime)
                    } label: {
                        Text("Terminé le")
                    }
                }
            }
        }
        .navigationTitle(reminder.title ?? "Rappel")
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
