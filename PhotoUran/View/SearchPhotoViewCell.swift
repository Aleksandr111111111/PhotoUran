//
//  SearchPhotoViewCell.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 25.09.2021.
//

import UIKit
import SDWebImage

class SearchPhotoViewCell: UITableViewCell {
	
	@IBOutlet weak var searchPhotoCell: UIImageView?
	
	func setupTabImage(model: URLModel?){
		guard let imageUrl = model?.urls.small, let url = URL(string: imageUrl) else { return }
		searchPhotoCell?.sd_setImage(with: url, completed: nil)
	}
	
}
