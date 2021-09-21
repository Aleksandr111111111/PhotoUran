//
//  NetworkService.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//
import Alamofire
import Foundation
class NetworkService {
	struct Constants {
		let url = "https://api.unsplash.com/photos/"
		let apiKey = "4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"
		let header = ["Authorization": "Client-ID 4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"]
	}
	
	func getFirstRequest(completion: ([FotoResult]) -> Void) {
		AF.request(Constants().url, parameters: ["page": String(1), "per_page": String(30)],  headers: ["Authorization": "Client-ID 4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"])
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.response{ response in
				//debugPrint(response)
				switch response.result {
				case .success:
					print(response)
				case .failure(let error):
					print(error)
				}
			}
			.responseDecodable(of: [FotoResult].self) { result in
				print("FirstRequest\(result)")
			}
	}
	
	func getSearchBarRequest(searchTerms: String, completion: ([FotoResult]) -> Void) {
		AF.request(Constants().url, parameters: ["query" : searchTerms, "page": String(1), "per_page": String(30)], headers: ["Authorization": "Client-ID 4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"])
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.response{ response in
				switch response.result {
				case .success:
					print("succes!\(response.result)")
				case .failure(let error):
					print(error)
				}
			}
			.responseDecodable(of: [FotoResult].self) { result in
				print("Search\(result)")
			}
	}
}
