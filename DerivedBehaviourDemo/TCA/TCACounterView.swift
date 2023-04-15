//
//  TCACounterView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI
import ComposableArchitecture

struct TCACounterView: View {
  let store: StoreOf<AppState>
  
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
      TCACounterView(store: Store(initialState: AppState.State(),
                                  reducer: AppState()._printChanges()))
    }
  }
}
