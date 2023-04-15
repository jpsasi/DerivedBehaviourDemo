//
//  TCAFavoritesView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI
import ComposableArchitecture

struct Favorites: ReducerProtocol {

  struct State: Equatable {
    var favorites: Set<Int>
    init(favorites: Set<Int> = []) {
      self.favorites = favorites
    }
  }
  
  enum Action {
    case removeFromFavorites(Int)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case let .removeFromFavorites(number):
        state.favorites.remove(number)
        return .none
    }
  }
}

struct TCAFavoritesView: View {
  let store: StoreOf<Favorites>
  
  var body: some View {
    WithViewStore(store, observe:{ $0 }) { viewStore in
      List {
        ForEach(viewStore.favorites.sorted(), id: \.self) { counter in
          HStack {
            Text("\(counter)")
            Spacer()
            Button("Delete") {
              viewStore.send(.removeFromFavorites(counter))
            }
            .foregroundColor(.red)
          }
        }
      }
      .listStyle(.plain)
      .navigationTitle("Favorites")
    }
  }
}

struct TCAFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TCAFavoritesView(store: Store(initialState: Favorites.State(),
                                    reducer: Favorites()))
    }
  }
}
