//
//  main.swift
//  
//
//  Created by sergey on 11.10.2020.
//

import AppleReceiptValidator
import ArgumentParser
import Foundation

struct MainCommand: ParsableCommand {

  static var configuration: CommandConfiguration = CommandConfiguration(commandName: "validate")

  @Option(help: "Base64 encoded receipt")
  var receipt: String

  @Option(help: "Your app secret")
  var secret: String

  @Option
  var printAsJson: Bool

  func run() throws {
    let validationResult = try Networking.requestData(
      ReceiptRequest(receipt: self.receipt, password: self.secret),
      functor: API.requestReceiptValidation
    )
    if self.printAsJson {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let encoded = try encoder.encode(validationResult)

      print(String(data: encoded, encoding: .utf8)!)
    } else {
      print(validationResult)
    }
  }
}

MainCommand.main()
