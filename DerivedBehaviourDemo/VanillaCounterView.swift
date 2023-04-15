//
//  VanillaCounterView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI

struct VanillaCounterView: View {
  @ObservedObject var viewModel: AppViewModel

  var body: some View {
    VStack {
      HStack {
        Button {
          viewModel.counter -= 1
        } label: {
          Text("-")
            .font(.largeTitle)
            .frame(width: 30)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 15))
        Text("\(viewModel.counter)")
          .font(.largeTitle)
          .padding(.horizontal)
        Button {
          viewModel.counter += 1
        } label: {
          Text("+")
            .font(.largeTitle)
            .frame(width: 30)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 15))
      }
      Button {
        if (viewModel.favorites.contains(viewModel.counter)) {
          viewModel.favorites.remove(viewModel.counter)
        } else {
          viewModel.favorites.insert(viewModel.counter)
        }
      } label: {
        if (viewModel.favorites.contains(viewModel.counter)) {
          Text("Remove From Favorites")
            .font(.largeTitle)
        } else {
          Text("Add to Favorites")
            .font(.largeTitle)
        }
      }
    }
    .navigationTitle("Counter")
  }
}

struct VanillaCounterView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {      
      VanillaCounterView(viewModel: AppViewModel())
    }
  }
}
