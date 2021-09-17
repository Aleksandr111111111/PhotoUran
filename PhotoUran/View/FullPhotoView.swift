//
//  FullPhotoView.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 13.09.2021.
//

import UIKit

class FullPhotoView: UIViewController {
	
	@IBOutlet weak var photoCell: UIImageView?
	
	var imageCell: FotoResult? {
		didSet {
			guard let imageUrl = imageCell?.urls["small"], let url = URL(string: imageUrl), let data = try? Data(contentsOf: url) else { return }
			let image = UIImage(data: data)
			photoCell?.image = image
		}
	}
}
