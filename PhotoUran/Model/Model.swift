//
//  Model.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import Foundation

struct FotoModel: Decodable {
	let urls: URLModel
	let width: Int
	let height: Int
}

struct URLModel: Decodable{
	let full: String
	let regular: String
	let small: String
	let thumb: String
}

