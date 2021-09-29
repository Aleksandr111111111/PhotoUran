//
//  PhotoViewCell.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import UIKit
import SDWebImage

class PhotoCollectionCell: UICollectionViewCell {
	
	@IBOutlet weak var photoCell: UIImageView?
	
	var imageCell: URLModel? {
		didSet {
			guard let imageUrl = imageCell?.urls.small, let url = URL(string: imageUrl) else { return }
			photoCell?.sd_setImage(with: url, completed: nil)
		}
	}
}


