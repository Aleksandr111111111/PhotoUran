//
//  PhotoCollectionView.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import UIKit

class PhotoCollectionView: UICollectionView {

	init() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		super.init(frame: .zero, collectionViewLayout: layout)

		register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.reuseId)
		
		
		translatesAutoresizingMaskIntoConstraints = false
		
	}	

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}
//
