//
//  ValidationResult.swift
//  
//
//  Created by sergey on 11.10.2020.
//

import Foundation

// MARK: - ValidationResult
public struct ValidationResult: Codable {
  public let status: Int
  public let environment: String
  public let receipt: Receipt
  public let latestReceiptInfo: [LatestReceiptInfo]
  public let latestReceipt: String
  public let pendingRenewalInfo: [PendingRenewalInfo]?

  enum CodingKeys: String, CodingKey {
    case environment, receipt
    case latestReceiptInfo = "latest_receipt_info"
    case latestReceipt = "latest_receipt"
    case pendingRenewalInfo = "pending_renewal_info"
    case status
  }
}

// MARK: - LatestReceiptInfo
public struct LatestReceiptInfo: Codable {
  public let quantity, productID, transactionID, originalTransactionID: String
  public let purchaseDate, purchaseDateMS, purchaseDatePst, originalPurchaseDate: String
  public let originalPurchaseDateMS, originalPurchaseDatePst, expiresDate, expiresDateMS: String
  public let expiresDatePst, webOrderLineItemID, isTrialPeriod, isInIntroOfferPeriod: String
  public let subscriptionGroupIdentifier: String?

  enum CodingKeys: String, CodingKey {
    case quantity
    case productID = "product_id"
    case transactionID = "transaction_id"
    case originalTransactionID = "original_transaction_id"
    case purchaseDate = "purchase_date"
    case purchaseDateMS = "purchase_date_ms"
    case purchaseDatePst = "purchase_date_pst"
    case originalPurchaseDate = "original_purchase_date"
    case originalPurchaseDateMS = "original_purchase_date_ms"
    case originalPurchaseDatePst = "original_purchase_date_pst"
    case expiresDate = "expires_date"
    case expiresDateMS = "expires_date_ms"
    case expiresDatePst = "expires_date_pst"
    case webOrderLineItemID = "web_order_line_item_id"
    case isTrialPeriod = "is_trial_period"
    case isInIntroOfferPeriod = "is_in_intro_offer_period"
    case subscriptionGroupIdentifier = "subscription_group_identifier"
  }
}

// MARK: - PendingRenewalInfo
public struct PendingRenewalInfo: Codable {
  public let autoRenewProductID, originalTransactionID, productID, autoRenewStatus: String

  enum CodingKeys: String, CodingKey {
    case autoRenewProductID = "auto_renew_product_id"
    case originalTransactionID = "original_transaction_id"
    case productID = "product_id"
    case autoRenewStatus = "auto_renew_status"
  }
}

// MARK: - Receipt
public struct Receipt: Codable {
  public let receiptType: String
  public let adamID, appItemID: Int
  public let bundleID, applicationVersion: String
  public let downloadID, versionExternalIdentifier: Int
  public let receiptCreationDate, receiptCreationDateMS, receiptCreationDatePst, requestDate: String
  public let requestDateMS, requestDatePst, originalPurchaseDate, originalPurchaseDateMS: String
  public let originalPurchaseDatePst, originalApplicationVersion: String
  public let inApp: [LatestReceiptInfo]

  enum CodingKeys: String, CodingKey {
    case receiptType = "receipt_type"
    case adamID = "adam_id"
    case appItemID = "app_item_id"
    case bundleID = "bundle_id"
    case applicationVersion = "application_version"
    case downloadID = "download_id"
    case versionExternalIdentifier = "version_external_identifier"
    case receiptCreationDate = "receipt_creation_date"
    case receiptCreationDateMS = "receipt_creation_date_ms"
    case receiptCreationDatePst = "receipt_creation_date_pst"
    case requestDate = "request_date"
    case requestDateMS = "request_date_ms"
    case requestDatePst = "request_date_pst"
    case originalPurchaseDate = "original_purchase_date"
    case originalPurchaseDateMS = "original_purchase_date_ms"
    case originalPurchaseDatePst = "original_purchase_date_pst"
    case originalApplicationVersion = "original_application_version"
    case inApp = "in_app"
  }
}
