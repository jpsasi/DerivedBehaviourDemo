//
//  DerivedBehaviourDemoApp.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct DerivedBehaviourDemoApp: App {
  var body: some Scene {
    WindowGroup {
      TCAContentView(store: Store(initialState: AppState.State(),
                                  reducer: AppState()._printChanges()))
    }
  }
}
