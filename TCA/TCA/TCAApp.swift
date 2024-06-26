//
//  TCAApp.swift
//  TCA
//
//  Created by Khai on 6/25/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
        ._printChanges()
    }
  
    var body: some Scene {
        WindowGroup {
            AppView(store: TCAApp.store)
        }
    }
}
