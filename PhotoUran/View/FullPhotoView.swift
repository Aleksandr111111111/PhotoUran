//
//  FullPhotoView.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 13.09.2021.
//

import UIKit
import SDWebImage

class FullPhotoView: UIViewController {
	
	@IBOutlet weak var photoCell: UIImageView?
	
	func setupImage(model: FotoModel?){
		guard let imageUrl = model?.urls.small, let url = URL(string: imageUrl) else { return }
		photoCell?.sd_setImage(with: url, completed: nil)
	}
}
