//
//  TCACounterView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI
import ComposableArchitecture

struct Counter: ReducerProtocol {
  struct State:Equatable {
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
    }
  }
}

struct TCACounterView: View {
  let store: StoreOf<Counter>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        HStack {
          Button {
            viewStore.send(.decrementTapped)
          } label: {
            Text("-")
              .font(.largeTitle)
              .frame(width: 30)
          }
          .buttonStyle(.borderedProminent)
          .buttonBorderShape(.roundedRectangle(radius: 15))
          Text("\(viewStore.counter)")
            .font(.largeTitle)
            .padding(.horizontal)
          Button {
            viewStore.send(.incrementTapped)
          } label: {
            Text("+")
              .font(.largeTitle)
              .frame(width: 30)
          }
          .buttonStyle(.borderedProminent)
          .buttonBorderShape(.roundedRectangle(radius: 15))
        }
        Button {
          if viewStore.favorites.contains(viewStore.counter) {
            viewStore.send(.removeFromFavoritesTapped)
          } else {
            viewStore.send(.addToFavoritesTapped)
          }
        } label: {
          if viewStore.favorites.contains(viewStore.counter) {
            Text("Remove from Favorites")
              .font(.largeTitle)
          } else {
            Text("Add to Favorites")
              .font(.largeTitle)
          }
        }
      }
    }
    .navigationTitle("Counter View")
  }
}

struct TCACounterView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TCACounterView(store: Store(initialState: Counter.State(),
                                  reducer: Counter()))
    }
  }
}
