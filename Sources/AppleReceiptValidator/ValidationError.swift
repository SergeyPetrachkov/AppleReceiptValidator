//
//  ValidationError.swift
//  
//
//  Created by sergey on 11.10.2020.
//

import Foundation

/// See https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html
public enum ValidationError: CustomNSError, LocalizedError {
  case unreadableJson
  case malformedRequest
  case unauthenticatedReceipt
  case invalidPassword
  case validationServerUnavailable
  case subscriptionExpired
  case sandboxReceiptSentToProdValidator
  case productionReceiptSentToSandboxValidator
  case purchaseNeverMade
  case internalDataAccessError(Int)
  case other(Int)

  public var errorCode: Int {
    switch self {
    case .unreadableJson:
      return 21000
    case .malformedRequest:
      return 21002
    case .unauthenticatedReceipt:
      return 21003
    case .invalidPassword:
      return 21004
    case .validationServerUnavailable:
      return 21005
    case .subscriptionExpired:
      return 21006
    case .sandboxReceiptSentToProdValidator:
      return 21007
    case .productionReceiptSentToSandboxValidator:
      return 21008
    case .purchaseNeverMade:
      return 21010
    case .internalDataAccessError(let code):
      return code
    case .other(let code):
      return code
    }
  }

  public static var errorDomain: String {
    return "AppleReceiptValidator.ValidationError"
  }

  public var errorDescription: String? {
    switch self {
    case .unreadableJson:
      return "ERROR: The App Store could not read the JSON object you provided."
    case .malformedRequest:
      return "ERROR: The data in the receipt-data property was malformed or missing."
    case .unauthenticatedReceipt:
      return "ERROR: The receipt could not be authenticated."
    case .invalidPassword:
      return "ERROR: The shared secret you provided does not match the shared secret on file for your account."
    case .validationServerUnavailable:
      return "ERROR: The receipt server is not currently available."
    case .subscriptionExpired:
      return "ERROR: This receipt is valid but the subscription has expired."
    case .sandboxReceiptSentToProdValidator:
      return "ERROR: This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead."
    case .productionReceiptSentToSandboxValidator:
      return "ERROR: This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead."
    case .purchaseNeverMade:
      return "ERROR: This receipt could not be authorized. Treat this the same as if a purchase was never made."
    case .internalDataAccessError(let code):
      return "ERROR: Internal data access error. Code: \(code)"
    case .other(let code):
      return "Unknown error (\(code))."
    }
  }

  init(code: Int) {
    switch code {
    case 21000:
      self = .unreadableJson
    case 21002:
      self = .malformedRequest
    case 21003:
      self = .unauthenticatedReceipt
    case 21004:
      self = .invalidPassword
    case 21005:
      self = .validationServerUnavailable
    case 21006:
      self = .subscriptionExpired
    case 21007:
      self = .sandboxReceiptSentToProdValidator
    case 21008:
      self = .productionReceiptSentToSandboxValidator
    case 21010:
      self = .purchaseNeverMade
    case 21100..<21200:
      self = .internalDataAccessError(code)
    default:
      self = .other(code)
    }
  }
}
