//
//  ContactDetailView.swift
//  TCA
//
//  Created by Khai on 6/28/24.
//

import ComposableArchitecture
import SwiftUI

struct ContactDetailView: View {
    @Bindable var store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        Form {
            Button("Delete") {
                store.send(.deleteButtonTapped)
            }
        }
        .navigationTitle(Text(store.contact.name))
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(
            store: Store(
                initialState: ContactDetailFeature.State(
                    contact: Contact(id: UUID(), name: "Blob")
                )
            ) {
                ContactDetailFeature()
            }
        )
    }
}
