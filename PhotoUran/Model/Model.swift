//
//  Model.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import Foundation

struct FotoModel: Decodable {
	let total: Int
	let results: [URLModel]
 }

 struct URLModel: Decodable {

	let urls: URLFotoResult
	let width: Int
	let height: Int

	struct URLFotoResult: Decodable {
	   let raw: String
	   let full: String
	   let regular: String
	   let small: String
	   let thumb: String
   }
 }
