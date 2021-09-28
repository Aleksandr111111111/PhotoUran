//
//  FullPhotoView.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 13.09.2021.
//

import UIKit
import SDWebImage

class FullPhotoView: UIViewController {
	
	@IBOutlet weak var fullPhoto: UIImageView?
	
	func setupFullImage(model: FotoModel?){
		guard let imageUrl = model?.urls.small, let url = URL(string: imageUrl) else { return }
		fullPhoto?.sd_setImage(with: url, completed: nil)
	}
}
