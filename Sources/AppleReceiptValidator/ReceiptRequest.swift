//
//  ReceiptRequest.swift
//  
//
//  Created by sergey on 11.10.2020.
//

import Foundation

public struct ReceiptRequest: Codable {
  public let receipt: String
  public let password: String

  public init(receipt: String, password: String) {
    self.receipt = receipt
    self.password = password
  }

  enum CodingKeys: String, CodingKey {
    case receipt = "receipt-data"
    case password
  }
}
