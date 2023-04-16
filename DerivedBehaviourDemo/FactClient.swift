//
//  FactClient.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 16/04/23.
//

import Foundation
import ComposableArchitecture

struct FactClient {
  var fetch: @Sendable (Int) async throws -> String
  //struct Error: Swift.Error, Equatable {}
}

extension FactClient {
  static let live = Self { number in
    let (data, _) = try await URLSession.shared.data(for:
                                                      URLRequest(url: URL(string: "http://numbersapi.com/\(number)")!))
    return String(decoding: data, as: UTF8.self)
  }
}
