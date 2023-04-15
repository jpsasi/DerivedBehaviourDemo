//
//  TCAFavoritesView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI
import ComposableArchitecture

struct TCAFavoritesView: View {
  let store: StoreOf<AppState>
  
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
      TCAFavoritesView(store: Store(initialState: AppState.State(),
                                    reducer: AppState()))
    }
  }
}
