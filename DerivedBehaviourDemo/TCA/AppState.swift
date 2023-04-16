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
    var counterFact: CounterFact.State
    
    init(counter: Int = 0, favorites: Set<Int> = [],
         counterFact: CounterFact.State = CounterFact.State()) {
      self.count = counter
      self.favorites = favorites
      self.counterFact = counterFact
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
    case counterFact(CounterFact.Action)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case let .counter(counterAction):
        return Counter().reduce(into: &state.counterState, action: counterAction)
          .map(AppState.Action.counter)
      case let .favorites(favoritesAction):
        return Favorites().reduce(into: &state.favoritesState, action: favoritesAction)
          .map(AppState.Action.favorites)
      case let .counterFact(counterFactAction):
        return CounterFact().reduce(into: &state.counterFact, action: counterFactAction)
          .map(AppState.Action.counterFact)
    }
  }
}
