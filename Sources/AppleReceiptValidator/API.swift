//
//  API.swift
//  
//
//  Created by sergey on 11.10.2020.
//

import Foundation

public enum API {

  struct ErrorResponse: Codable {
    let status: Int
  }

  public static func requestReceiptValidation(request: ReceiptRequest, completion: @escaping (Result<ValidationResult, Error>) -> Void) {

    let bodyData = try! JSONEncoder().encode(request)

    let url = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.uploadTask(with: request, from: bodyData) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      // Here we only accept server response code 200
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        print("Unexpected server response")
        return
      }

      if let mimeType = response.mimeType,
         mimeType == "application/json",
         let data = data {

        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(ValidationResult.self, from: data)
          completion(.success(result))
        } catch {
          if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
            completion(.failure(ValidationError(code: errorResponse.status)))
          } else {
            completion(.failure(error))
          }
        }
      }
    }

    task.resume()
  }
}
