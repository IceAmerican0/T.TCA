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
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
        ._printChanges()
    }
  
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCAApp.store)
        }
    }
}
