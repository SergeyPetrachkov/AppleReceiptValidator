//
//  Helpers.swift
//  
//
//  Created by sergey on 11.10.2020.
//

import Foundation

public typealias FlatResult<T> = Swift.Result<T, Error>

public typealias StatusCode = Int

public typealias APIFunctor<Request, Response> = ((_ request: Request, _ completion: @escaping (FlatResult<Response>) -> Void) -> Void)
public typealias APISimpleFunctor<Response> = ((_ completion: @escaping (FlatResult<Response>) -> Void) -> Void)

enum APIError: Error {
  case unrecognizedError
}

public enum Networking {
  /// Request any data from backend and return response model or throw an error
  ///   - Parameters:
  ///     - request: api request model provided by you client
  ///     - functor: method from your API class
  ///   - returns: unwrapped model of type declared by functor in `completion`
  ///   - throws: APIError
  ///
  ///
  public static func requestData<Request, Response>(
    _ request: Request,
    functor: @escaping APIFunctor<Request, Response>
  ) throws -> Response {
    var result: Response?
    var resultingError: Error?
    let group = DispatchGroup()
    group.enter()
    functor(request) { response in
      switch response {
      case .success(let value):
        result = value
      case .failure(let error):
        resultingError = error
      }
      group.leave()
    }
    group.wait()
    if let result = result {
      return result
    } else if let error = resultingError {
      throw error
    } else {
      throw APIError.unrecognizedError
    }
  }
}
