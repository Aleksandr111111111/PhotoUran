//
//  ViewController.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//
import UIKit

class CollectionViewController: UIViewController {
	struct Constants {
		let insetsImage = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		let countImageHeight:CGFloat = 3.0
		let countSimbols = 2
		let sizePhotoForView:CGFloat = 0.85
		let countSpasing:CGFloat = 1.0
		let cellId = "CellPhoto"
		let idDidSelect = "FullPhotoView"
		let allPhoto = ""
		let sizeIndentation = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	@IBOutlet weak var photoCollectionView: UICollectionView!
	var arrayFotoModel = [FotoModel]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		allPhoto()
		setapCollectionView()
	}
	
	func allPhoto() {
		DispatchQueue.main.async {
			NetworkService().getRequest(searchTerms: Constants().allPhoto) { [weak self] (photos) in
				self?.arrayFotoModel = photos
				self?.photoCollectionView.reloadData()
			}
		}
	}
	
	func setapCollectionView() {
		self.photoCollectionView.delegate = self
		self.photoCollectionView.dataSource = self
	}
}

//MARK:   UICollectionViewDataSource,
extension CollectionViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return arrayFotoModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: Constants().cellId, for: indexPath) as! PhotoCollectionCell
		cell.imageCell = self.arrayFotoModel[indexPath.item]
		return cell
	}
}

//MARK: UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
		let fullPhotoView = storyboard?.instantiateViewController(withIdentifier: Constants().idDidSelect) as! FullPhotoView
		navigationController?.pushViewController(fullPhotoView, animated: true)
		collectionView.deselectItem(at: indexPath, animated: true)

		DispatchQueue.main.async {
			fullPhotoView.setupImage(model: self.arrayFotoModel[indexPath.item])
			fullPhotoView.reloadInputViews()
		}
	}
}

//MARK: UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let photo = arrayFotoModel[indexPath.item]
		let spasing = (Constants().countImageHeight + Constants().countSpasing) * Constants().insetsImage.left
		let overallWidthCell = view.frame.width - spasing
		let widthtCell = (overallWidthCell / Constants().countImageHeight)
		let heightCell = CGFloat(photo.height) * widthtCell / CGFloat(photo.width)
		return CGSize.init(width: widthtCell, height: heightCell)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return Constants().insetsImage
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Constants().insetsImage.left
	}
}