//
//  RemindersView.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 12/06/2026.
//

import SwiftData
import SwiftUI

struct RemindersView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Reminder.date) private var reminders: [Reminder]

    @State private var selectedReminder: Reminder?
    @State private var reminderToEdit: Reminder?
    @State private var showRemindersForm = false

    var body: some View {
        NavigationSplitView {
            List(reminders, selection: $selectedReminder) { reminder in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(
                            systemName: reminder.completedAt == nil
                                ? "circle"
                                : "checkmark.circle.fill"
                        )
                        .foregroundColor(
                            reminder.completedAt == nil
                                ? .secondary
                                : .green
                        )

                        Text(reminder.title ?? "Sans titre")
                            .font(.headline)
                    }

                    if let date = reminder.date {
                        Text(date, format: .dateTime)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .tag(reminder)
                .swipeActions(edge: .leading) {
                    if reminder.completedAt == nil {
                        Button {
                            toggleCompleted(reminder)
                        } label: {
                            Label(
                                "Terminer",
                                systemImage: "checkmark.circle.fill"
                            )
                        }
                        .tint(.green)
                    } else {
                        Button {
                            toggleCompleted(reminder)
                        } label: {
                            Label(
                                "Réactiver",
                                systemImage: "arrow.uturn.backward.circle"
                            )
                        }
                        .tint(.orange)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        deleteReminder(reminder)
                    } label: {
                        Label("Supprimer", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Rappels")
            .toolbar {
                ToolbarItem {
                    Button {
                        showRemindersForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Ajouter un rappel")
                }
            }
            .sheet(isPresented: $showRemindersForm) {
                RemindersFormView()
            }
            .sheet(item: $reminderToEdit) { reminder in
                RemindersFormView(reminderToEdit: reminder)
            }
        } detail: {
            if let reminder = selectedReminder {
                RemindersDetailView(reminder: reminder) {
                    reminderToEdit = reminder
                }
            } else {
                ContentUnavailableView(
                    "Aucun rappel sélectionné",
                    systemImage: "bell",
                    description: Text("Sélectionnez un rappel dans la liste.")
                )
            }
        }
    }

    private func toggleCompleted(_ reminder: Reminder) {
        withAnimation {
            reminder.completedAt =
                reminder.completedAt == nil
                ? .now
                : nil

            saveContext()
        }
    }

    private func deleteReminder(_ reminder: Reminder) {
        withAnimation {
            if selectedReminder?.persistentModelID
                == reminder.persistentModelID
            {
                selectedReminder = nil
            }

            modelContext.delete(reminder)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save reminders: \(error.localizedDescription)")
        }
    }
}
