//
//  Model.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import Foundation

struct Fotos: Decodable {
	let total: Int
	let results: [FotoResult]
}


struct FotoResult: Decodable {
	
	let urls: [URLFotoResult.RawValue : String]
	let width: Int
	let height: Int
	
	enum URLFotoResult: String {
		case raw
		case full
		case regular
		case small
		case thumb
	}
}

