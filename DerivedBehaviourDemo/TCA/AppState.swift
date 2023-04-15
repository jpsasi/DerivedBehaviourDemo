//
//  AppState.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import Foundation
import ComposableArchitecture

struct AppState: ReducerProtocol {
  struct State: Equatable {
    var counter: Int
    var favorites: Set<Int>
    
    init(counter: Int = 0, favorites: Set<Int> = []) {
      self.counter = counter
      self.favorites = favorites
    }
  }
  
  enum Action {
    case incrementTapped
    case decrementTapped
    case addToFavoritesTapped
    case removeFromFavoritesTapped
    case removeFromFavorites(Int)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case .incrementTapped:
        state.counter += 1
        return .none
      case .decrementTapped:
        state.counter -= 1
        return .none
      case .addToFavoritesTapped:
        state.favorites.insert(state.counter)
        return .none
      case .removeFromFavoritesTapped:
        state.favorites.remove(state.counter)
        return .none
      case let .removeFromFavorites(number):
        state.favorites.remove(number)
        return .none
    }
  }
}
