//
//  ContentView.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<StoredUser>
    
    @State private var searchText = ""
    @State private var attemptedDataFetch = false
    @State private var showingSortOptions = false
    @State private var sortDescriptors: [SortDescriptor<StoredUser>] = []
    
    var body: some View {
        NavigationView {
            FilteredList(filterKey: "name", filterValue: searchText, predicateKey: .contains, sortDescriptors: sortDescriptors) { (user: StoredUser) in
                userListRow(user: user)
                .padding(.vertical, 3)
            }
            .searchable(text: $searchText, prompt: "Look for someone")
            .navigationTitle("FriendBase")
            .task {
                // Fetches new data once upon launching app and updates Core Data objects
                guard !attemptedDataFetch else { return }
                await UsersDataManager.shared.updateCachedUsers(users, moc: moc)
            }
            .confirmationDialog("Sort Options", isPresented: $showingSortOptions) {
                // Sort Options
                Button("A-Z") { sortDescriptors = [SortDescriptor(\.name)] }
                Button("Z-A") { sortDescriptors = [SortDescriptor(\.name, order: .reverse)] }
                Button("Default") { sortDescriptors = [] }
            }
            .toolbar {
                // Sort button
                Button {
                    showingSortOptions = true
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
        }
    }
}

extension HomeView {
    private func userListRow(user: StoredUser) -> some View {
        NavigationLink {
            UserDetailView(user: user)
        } label: {
            HStack {
                ActiveIndicator(isActive: user.isActive
                )
                VStack(alignment: .leading) {
                    Text(user.wrappedName)
                    Text(user.isActive ? "Active" : "Inactive")
                        .font(.caption)
                        .foregroundColor(user.isActive ? .green : .secondary)
                }
                Spacer()
            }
        }
    }
}
