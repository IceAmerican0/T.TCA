//
//  CounterFeature.swift
//  TCA
//
//  Created by Khai on 6/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factResponse(String)
        case factButtonTapped
        case timerTick
        case toggleTimerButtonTapped
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
  
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count] send in
                    // ✅ Do async work in here, and send actions back into the system.
                    try await send(.factResponse(self.numberFact.fetch(count)))
                }
                
                /*
                 // 🛑 'async' call in a function that does not support concurrency
                 // 🛑 Errors thrown from here are not handled
                 
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
                
                state.fact = String(decoding: data, as: UTF8.self)
                state.isLoading = false
                
                return .none
                */
                
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
            }
        }
    }
}
