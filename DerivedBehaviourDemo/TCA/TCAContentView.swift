//
//  TCAContentView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI
import ComposableArchitecture

struct TCAContentView: View {
  let store: StoreOf<AppState>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      TabView {
        NavigationView {
          TCACounterView(store: store.scope(state: \.counterState, action: AppState.Action.counter))
        }
        .tabItem {
          Label("Counter \(viewStore.count)", systemImage: "number.circle.fill")
        }
        NavigationView {
          TCAFavoritesView(store: store.scope(state: \.favoritesState, action: AppState.Action.favorites))
        }
        .tabItem {
          Label("Favorites \(viewStore.favorites.count)", systemImage: "star.circle.fill")
        }
      }
    }
  }
}

struct TCAContentView_Previews: PreviewProvider {
  static var previews: some View {
    TCAContentView(store: Store(initialState: AppState.State(),
                                reducer: AppState()))
  }
}
