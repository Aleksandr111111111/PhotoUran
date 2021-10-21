//
//  NetworkMoya.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 21.10.2021.
//

import Foundation
import Moya

protocol NetworkServiceProtocol {
	func getAllPhoto(completion: @escaping(Result<[URLModel]?, Error>) -> Void)
	func getSearchPhoto(searchTerms: String, completion: @escaping(Result<[URLModel]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
	
	let requestPhoto = MoyaProvider<RequesService>()
	
	func getSearchPhoto(searchTerms: String, completion: @escaping (Result<[URLModel]?, Error>) -> Void) {
		requestPhoto.request(.requstSearch(searchTerms)) { (result) in
			switch result {
			case .success(let response):
				do {
					let photos = try JSONDecoder().decode(FotoModel.self, from: response.data)
					completion(.success(photos.results))
				} catch let error {
					completion(.failure(error))
					print(error)
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func getAllPhoto(completion: @escaping (Result<[URLModel]?, Error>) -> Void) {
		requestPhoto.request(.requestAllPhoto) { (result) in
			switch result {
			case .success(let response):
				do {
					let photos = try JSONDecoder().decode([URLModel].self, from: response.data)
					completion(.success(photos))
				} catch let error {
					completion(.failure(error))
					print(error)
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}
