//
//  FullPhotoView.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 13.09.2021.
//

import UIKit

class FullPhotoView: UIViewController {
	
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

	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupFullImage()
	}
	
	private func setupFullImage() {
		view.addSubview(photoCell)
		photoCell.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		photoCell.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		photoCell.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		photoCell.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		
	}
	
}
