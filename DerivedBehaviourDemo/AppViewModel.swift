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
  
  init() {
    self.counter = CounterViewModel()
    self.favorites = FavoritesViewModel()
    
    self.counter.objectWillChange
      .sink { [weak self] in self?.objectWillChange.send() }
      .store(in: &cancellables)
    
    self.favorites.objectWillChange
      .sink { [weak self] in self?.objectWillChange.send() }
      .store(in: &cancellables)
    
    self.counter.$favorites
      .removeDuplicates()
      .assign(to: &self.favorites.$favorites)
    self.favorites.$favorites
      .removeDuplicates()
      .assign(to: &self.counter.$favorites)
  }
}
