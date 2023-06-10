//
//  ContentNetwork.swift
//  Workday Coding
//
//  Created by Miguel Angeles on 6/9/23.
//

import Foundation

protocol ContentFetchable {
  func fetchContent(_ search : String, _ page: Int, completion: @escaping ((Result<[Content], Error>) -> ()))
}

final class ContentNetwork: ContentFetchable {

  private enum Constants {
    static let baseUrlString = "https://jsonplaceholder.typicode.com/search"
      
      
  }

  enum APIErrors: Error {
    case malformedURL
    case invalidData
    case invalidRequest(error: Error)
    case decodingError
  }

  let urlSession: URLSession
  let contentBuilder: ContentBuilder

  init(urlSession: URLSession = .shared, contentBuilder: ContentBuilder = ContentBuilder()) {
    self.urlSession = urlSession
    self.contentBuilder = contentBuilder
  }

    func fetchContent(_ search : String, _ page: Int, completion: @escaping ((Result<[Content], Error>) -> ())) {
    //let endPointString = Constants.baseUrlString.appending(Constants.contentEndPoint)
    var urlComponents = URLComponents(string: Constants.baseUrlString)!
      urlComponents.queryItems = [
        URLQueryItem(name: "q", value: search),
        URLQueryItem(name: "page_size", value: "20"),
        URLQueryItem(name: "page", value: String(page))
      ]
      
        guard let endpoint = urlComponents.url else {
      completion(.failure(APIErrors.malformedURL))
      return
    }
    
    let dataTask = urlSession.dataTask(with: endpoint) { [weak self] (data, response, error) in

      guard let self = self else { return }

      if let error = error {
        completion(.failure(APIErrors.invalidRequest(error: error)))
        return
      }

      guard let data = data else {
        completion(.failure(APIErrors.invalidData))
        return
      }

      do {
        let contents = try self.contentBuilder.decode(data: data)
        completion(.success(contents))
      } catch {
        completion(.failure(APIErrors.decodingError))
      }
    }

    dataTask.resume()
  }

}
