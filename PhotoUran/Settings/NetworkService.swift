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
		let header: HTTPHeaders = ["Authorization": "Client-ID 4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"]
		let contentType = ["application/json"]
		let statusCode = 200..<300
		
		func prepareParameters(searchTerms: String?) -> [String: String] {
			var parameters = [String: String]()
			parameters["query"] = searchTerms
			parameters["page"] = String(1)
			parameters["per_page"] = String(30)
			return parameters
		}
	}
	
	func getRequest(searchTerms: String, completion: @escaping([FotoModel]) -> Void) {
		AF.request(Constants().url, parameters: Constants().prepareParameters(searchTerms: searchTerms), headers: Constants().header)
			.validate(statusCode: Constants().statusCode)
			.validate(contentType: Constants().contentType)
			.responseDecodable(of: [FotoModel].self) { response in
				guard let propertyResponse = response.value else {return}
				completion(propertyResponse)
		}
	}
}
