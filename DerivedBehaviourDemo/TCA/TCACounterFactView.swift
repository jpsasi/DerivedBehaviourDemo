//
//  TCACounterFactView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 16/04/23.
//

import SwiftUI
import ComposableArchitecture

struct CounterFact: ReducerProtocol {
  var factClient: FactClient = FactClient.live
  var mainQueue: AnySchedulerOf<DispatchQueue> = .main
  
  struct State: Equatable {
    var count: Int
    var alert: Alert?
    
    struct Alert: Equatable, Identifiable {
      var message: String
      var title: String
      var id: String {
        title + message
      }
    }
    
    init(count: Int = 0, alert: Alert? = nil) {
      self.count = count
      self.alert = alert
    }
  }
  
  enum Action {
    case incrButtonTapped
    case decrButtonTapped
    case dismissAlert
    case factButtonTapped
    case factResponse(Result<String, FactClient.Error>)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      case .incrButtonTapped:
        state.count += 1
        return .none
      case .decrButtonTapped:
        state.count -= 1
        return .none
      case .dismissAlert:
        state.alert = nil
        return .none
      case .factButtonTapped:
        return factClient.fetch(state.count)
          .receive(on: mainQueue.animation())
          .catchToEffect()
          .map(CounterFact.Action.factResponse)
      case let .factResponse(.success(fact)):
        state.alert = .init(message: fact, title: "Fact")
        return .none
      case .factResponse(.failure):
        state.alert = .init(message: "Couldn't load fact", title: "Fact")
        return .none
    }
  }
}

struct TCACounterFactView: View {
  let store: StoreOf<CounterFact>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        HStack {
          Button {
            viewStore.send(.decrButtonTapped)
          } label: {
            Text("-")
              .font(.title)
          }
          Text("\(viewStore.count)")
            .font(.title3)
          Button {
            viewStore.send(.incrButtonTapped)
          } label: {
            Text("+")
              .font(.title)
          }
        }
        .padding(.horizontal)
        Button("Fact") {
          viewStore.send(.factButtonTapped)
        }
      }
      .alert(item: viewStore.binding(get: \.alert, send: .dismissAlert)) { alert in
        Alert(title: Text(alert.title), message: Text(alert.message))
      }
    }
  }
}

struct TCACounterFact_Previews: PreviewProvider {
  static var previews: some View {
    TCACounterFactView(store: Store(initialState: CounterFact.State(),
                                reducer: CounterFact()))
  }
}
