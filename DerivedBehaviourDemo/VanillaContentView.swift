//
//  VanillaContentView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI

struct VanillaContentView: View {
  
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
    TabView {
      NavigationView {
        VanillaCounterView(viewModel: viewModel.counter)
      }
      .tabItem {
        Label("Counter \(viewModel.counter.counter)", systemImage: "number.circle.fill")
      }
      NavigationView {
        VanillaFavoritesView(viewModel: viewModel.favorites)
      }
      .tabItem {
        Label("Favorites \(viewModel.counter.favorites.count)", systemImage: "star.circle.fill")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VanillaContentView(viewModel: AppViewModel())
    }
  }
}
