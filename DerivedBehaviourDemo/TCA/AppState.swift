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
    var count: Int
    var favorites: Set<Int>
    
    init(counter: Int = 0, favorites: Set<Int> = []) {
      self.count = counter
      self.favorites = favorites
    }
    
    var counterState: Counter.State {
      get {
        .init(counter: count, favorites: favorites)
      }
      set {
        self.count = newValue.counter
        self.favorites = newValue.favorites
      }
    }
    
    var favoritesState: Favorites.State {
      get {
        .init(favorites: favorites)
      }
      set {
        self.favorites = newValue.favorites
      }
    }
  }
  
  enum Action {
    case counter(Counter.Action)
    case favorites(Favorites.Action)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case let .counter(counterAction):
        return Counter().reduce(into: &state.counterState, action: counterAction)
          .map(AppState.Action.counter)
      case let .favorites(favoritesAction):
        return Favorites().reduce(into: &state.favoritesState, action: favoritesAction)
          .map(AppState.Action.favorites)
    }
  }
}
