//
//  TCACounterFactCollectionView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 16/04/23.
//

import SwiftUI
import ComposableArchitecture

struct CounterFactCollection: ReducerProtocol {
  let factClient: FactClient = .live
  let mainQueue: AnySchedulerOf<DispatchQueue> = .main
  let uuid:() -> UUID = { UUID() }
  
  struct State: Equatable {
    var counters: IdentifiedArrayOf<CounterRowFact.State>
    
    init(counters: IdentifiedArrayOf<CounterRowFact.State> = []) {
      self.counters = counters
    }
  }
  
  enum Action {
    case addButtonTapped
    case counterRow(id: UUID, action: CounterRowFact.Action)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case .addButtonTapped:
        state.counters.append(.init())
        return .none
      case let .counterRow(id: id, action: .removeButtonTapped):
        state.counters.remove(id: id)
        return .none
      case .counterRow:
        return .none
    }
  }
}

struct TCACounterFactCollectionView: View {
  let store: StoreOf<CounterFactCollection>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        ForEachStore(store.scope(state: \.counters, action: CounterFactCollection.Action.counterRow(id:action:))) { rowStore in
            TCACounterRowFactView(store: rowStore)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Counter Collection")
      .navigationBarItems(trailing: Button("Add") {
        viewStore.send(.addButtonTapped, animation: .default)
      })
    }
  }
}

struct TCACounterFactCollectionView_Previews: PreviewProvider {
  static var previews: some View {
    TCACounterFactCollectionView(store: Store(initialState: CounterFactCollection.State(),
                                              reducer: CounterFactCollection()))
  }
}
