//
//  AppViewModel.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
  let counter: CounterViewModel
  let favorites: FavoritesViewModel
  var cancellables: Set<AnyCancellable> = []
  
  init(
    counter: CounterViewModel = .init(),
    favorites: FavoritesViewModel = .init()
  ) {
    self.counter = counter
    self.favorites = favorites
    
    var favoriteIsUpdating = false
    var counterIsUpdating = false
    self.counter.objectWillChange
      .sink { [weak self] in self?.objectWillChange.send() }
      .store(in: &cancellables)
    
    self.favorites.objectWillChange
      .sink { [weak self] in self?.objectWillChange.send() }
      .store(in: &cancellables)

    self.counter.$favorites.sink { [weak self] in
      guard !counterIsUpdating else { return }
      favoriteIsUpdating = true
      defer { favoriteIsUpdating = false }
      self?.favorites.favorites = $0
    }
    .store(in: &self.cancellables)
    
    self.favorites.$favorites.sink { [weak self] in
      guard !favoriteIsUpdating else { return }
      counterIsUpdating = true
      defer { counterIsUpdating = false }
      self?.counter.favorites = $0
    }
    .store(in: &self.cancellables)    
  }
}
