//
//  AppFeatureTests.swift
//  TCA
//
//  Created by Khai on 6/26/24.
//

import ComposableArchitecture
import XCTest

@testable import TCA

final class AppFeatureTests: XCTestCase {
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
