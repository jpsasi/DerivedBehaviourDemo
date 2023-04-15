//
//  AppViewModel.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import Foundation

class AppViewModel: ObservableObject {
  @Published var counter: Int = 0
  @Published var favorites: Set<Int> = []
}
