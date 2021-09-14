//
//  ParserData.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import Foundation
class ParserData {
	
	var networkService = NetworkService()
	
	func getImages(searchTerms: String, completion: @escaping (Fotos?) -> () ) {
		networkService.request(searchTerms: searchTerms) { (data, error) in
			if let error = error {
				print("error \(error.localizedDescription)")
				completion(nil)
			}
//			let decoder = JSONDecoder()
//			guard let data = data else { return }
//			do {
//				let foto = try decoder.decode(Fotos.self, from: data)
//
//				} catch  let jsonError {
//					print("Error json", jsonError)
//				}
			let decode = self.decodeJSON(type: Fotos.self, from: data)
			completion(decode)
			
		}
	}
	
	func getAllImages(searchTerms: String, completion: @escaping (Fotos?) -> () ) {
		networkService.request(searchTerms: "/photo") { (data, error) in
			if let error = error {
				print("error \(error.localizedDescription)")
				completion(nil)
			}
			
			let decode = self.decodeJSON(type: Fotos.self, from: data)
			completion(decode)
		}
	}
	
	func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
		let decoder = JSONDecoder()
		guard let data = from else { return nil }

		do {
			let foto = try decoder.decode(type.self, from: data)
			return foto
			} catch  let jsonError{
				print("Error json", jsonError)
				return nil
			}
	}
}
