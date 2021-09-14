//
//  NetworkService.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import Foundation
class NetworkService {
	
	private let apiKey = "4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"
	
	func request(searchTerms: String, completion: @escaping (Data?, Error?) -> Void) {
		let parameters = self.prepareParameters(searchTerms: searchTerms)
		let url = self.url(paramms: parameters)
		//print(url)
		var request = URLRequest(url: url)
		request.allHTTPHeaderFields = prepareHeader()
		request.httpMethod = "get"
		let taskGet = createDataTask(from: request, completion: completion)
		taskGet.resume()
		
	}
	
	private func prepareHeader() -> [String: String]? {
		var headers = [String: String]()
		headers["Authorization"] = "Client-ID \(apiKey)"
		return headers
	}
	
	private func prepareParameters(searchTerms: String?) -> [String: String] {
		var parameters = [String: String]()
		parameters["query"] = searchTerms
		parameters["page"] = String(1)
		parameters["per_page"] = String(30)
		return parameters
	}
	
	private func url(paramms: [String: String]) -> URL {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.unsplash.com"
		components.path = "/search/photos"
		components.queryItems = paramms.map { URLQueryItem(name: $0, value: $1) }
		return components.url!
	}
	
	private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void ) -> URLSessionDataTask {
		return URLSession.shared.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				completion(data, error)
			}
		}
	}
}
