//
//  VanillaFavoritesView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
  @Published var favorites: Set<Int> = []
}

struct VanillaFavoritesView: View {
  @ObservedObject var viewModel: FavoritesViewModel
  
  var body: some View {
    List {
      ForEach(viewModel.favorites.sorted(), id: \.self) { counter in
        HStack {
          Text("\(counter)")
          Spacer()
          Button {
            viewModel.favorites.remove(counter)
          } label: {
            Text("Delete")
              .foregroundColor(.red)
          }
        }
      }
    }
    .listStyle(.plain)
    .navigationTitle("Favorites View")
  }
}

struct VanillaFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VanillaFavoritesView(viewModel: FavoritesViewModel())
    }
  }
}
