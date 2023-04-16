//
//  FactClient.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 16/04/23.
//

import Foundation
import ComposableArchitecture

struct FactClient {
  var fetch: (Int) -> Effect<String, Error>
  
  struct Error: Swift.Error, Equatable {}
}

extension FactClient {
  static let live = Self { number in
    URLSession.shared.dataTaskPublisher(for: URL(string: "http://numbersapi.com/\(number)")!)
      .map { data, _ in String(decoding: data, as: UTF8.self) }
      .mapError { error in
        print("error \(error)")
        return Error()
      }
      .eraseToEffect()
  }
}
