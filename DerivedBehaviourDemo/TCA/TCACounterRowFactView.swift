//
//  TCACounterRowFactView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 16/04/23.
//

import SwiftUI
import ComposableArchitecture

struct CounterRowFact: ReducerProtocol {
  struct State: Equatable, Identifiable {
    var counter: CounterFact.State
    let id: UUID
    
    init(counter: CounterFact.State = CounterFact.State(), id: UUID = UUID()) {
      self.counter = counter
      self.id = id
    }
  }
  
  enum Action {
    case counter(CounterFact.Action)
    case removeButtonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case .counter(let action):
        return CounterFact().reduce(into: &state.counter, action:action)
          .map(CounterRowFact.Action.counter)
      case .removeButtonTapped:
        return .none
    }
  }
}

struct TCACounterRowFactView: View {
  let store: StoreOf<CounterRowFact>
  
  var body: some View {
    HStack {
      TCACounterFactView(store: store.scope(state: \.counter, action: CounterRowFact.Action.counter))
      Spacer()
      WithViewStore(store.stateless) { viewStore in
        Button("Delete") {
          viewStore.send(.removeButtonTapped, animation: .default)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
      }
    }
  }
}

struct TCACounterRowFactView_Previews: PreviewProvider {
  static var previews: some View {
    TCACounterRowFactView(store: Store(initialState: CounterRowFact.State(),
                                       reducer: CounterRowFact()))
  }
}
