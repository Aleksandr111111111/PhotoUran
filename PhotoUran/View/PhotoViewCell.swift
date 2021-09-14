//
//  PhotoViewCell.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
	
	static let reuseId = "CellPhoto"
	
	let photoCell: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		
		return imageView
	}()
	
	var imageCell: FotoResult! {
		didSet {
			
			if let imageUrl = URL(string: (imageCell.urls["small"])!) {
				let data = try? Data(contentsOf: imageUrl)
				let image = UIImage(data: data!)
				
				photoCell.image = image
			}
		}
	}
	
	func setupPhotoCell() {
		addSubview(photoCell)
		photoCell.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		photoCell.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		photoCell.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		photoCell.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		photoCell.center.x = center.x
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupPhotoCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
