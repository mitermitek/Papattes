//
//  PetsView.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 12/06/2026.
//

import SwiftUI
import SwiftData

struct PetsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Pet.name) private var pets: [Pet]

    @State private var selectedPet: Pet?
    @State private var petToEdit: Pet?
    @State private var showPetsForm = false
    @State private var showDeleteConfirmation = false
    @State private var petToDelete: Pet?

    var body: some View {
        NavigationSplitView {
            List(pets, selection: $selectedPet) { pet in
                VStack(alignment: .leading, spacing: 4) {
                    Text(pet.name ?? "Sans nom")
                        .font(.headline)

                    HStack(spacing: 8) {
                        Text(pet.species?.label ?? "Espèce inconnue")
                        Text("•")
                        Text(pet.sex?.label ?? "Sexe inconnu")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .tag(pet)
                .swipeActions(edge: .leading) {
                    Button {
                        petToEdit = pet
                    } label: {
                        Label("Modifier", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        confirmDelete(pet)
                    } label: {
                        Label("Supprimer", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Animaux")
            .toolbar {
                ToolbarItem {
                    Button {
                        showPetsForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Ajouter un animal")
                }
            }
            .sheet(isPresented: $showPetsForm) {
                PetsFormView()
            }
            .sheet(item: $petToEdit) { pet in
                PetsFormView(petToEdit: pet)
            }
            .alert("Supprimer cet animal ?", isPresented: $showDeleteConfirmation, actions: {
                Button("Supprimer", role: .destructive) {
                    if let petToDelete {
                        deletePet(petToDelete)
                    }
                }
                Button("Annuler", role: .cancel) {}
            }, message: {
                Text("Cette action supprimera également toutes les données liées à cet animal.")
            })
        } detail: {
            if let pet = selectedPet {
                PetsDetailView(pet: pet) {
                    petToEdit = pet
                }
            } else {
                ContentUnavailableView(
                    "Aucun animal sélectionné",
                    systemImage: "pawprint",
                    description: Text("Sélectionnez un animal dans la liste.")
                )
            }
        }
    }

    private func confirmDelete(_ pet: Pet) {
        petToDelete = pet
        showDeleteConfirmation = true
    }

    private func deletePet(_ pet: Pet) {
        withAnimation {
            if selectedPet?.persistentModelID == pet.persistentModelID {
                selectedPet = nil
            }
            modelContext.delete(pet)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save pet: \(error.localizedDescription)")
        }
    }
}
