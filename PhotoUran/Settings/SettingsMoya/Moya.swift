//
//  Moya.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 21.10.2021.
//

import Foundation
import Moya

struct Constants {
	let urls = "https://api.unsplash.com/"
	let urlSearch = "search/photos/"
	let urlPhoto = "photos"
	let header = ["Authorization": "Client-ID 4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"]
	func prepareParameters(searchTerms: String?) -> [String: String] {
		var parameters = [String: String]()
		parameters["query"] = searchTerms
		parameters["page"] = String(1)
		parameters["per_page"] = String(30)
		return parameters
	}
	
	func prepareParameter() -> [String: String] {
		var parameters = [String: String]()
		parameters["page"] = String(1)
		parameters["per_page"] = String(30)
		return parameters
	}
}

enum RequesService {
	case requstSearch(String)
	case requestAllPhoto
}

extension RequesService: TargetType {
	var baseURL: URL {
		return  URL(string: Constants().urls)!
	}
	 
	var path: String {
		switch self {
		case .requstSearch:
			return Constants().urlSearch
		case .requestAllPhoto:
			return Constants().urlPhoto
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .requstSearch, .requestAllPhoto:
			return .get
		}
	}
	
	var task: Task {
		switch self {
		case .requestAllPhoto:
			return .requestParameters(
				parameters: Constants().prepareParameter(), encoding: URLEncoding.default)
		case .requstSearch(let searchTerms):
			return .requestParameters(
				parameters: Constants().prepareParameters(searchTerms: searchTerms), encoding: URLEncoding.queryString)
		}
	}
	
	var headers: [String : String]? {
		return Constants().header
	}
}
