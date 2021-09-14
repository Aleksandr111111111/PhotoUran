//
//  ViewController.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//

import UIKit

class ViewController: UIViewController {
	let image = FullPhotoView()
	var photo: Int = 0
	let isPageRefreshing:Bool = false
	let countImageHeight:CGFloat = 3.0
	private var parserData = ParserData()
	private var array = [FotoResult]()
	private var photoCollectionView = PhotoCollectionView()
	let insetsImage = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 60)
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		view.addSubview(photoCollectionView)
		photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
		photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
	
		photoCollectionView.backgroundColor = .lightGray
		photoCollectionView.delegate = self
		photoCollectionView.dataSource = self
		photoCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
		photoCollectionView.contentInsetAdjustmentBehavior = .automatic
		
		allPhoto(photos: 0)
		setupSearchBar()
	}
	
	private func allPhoto(photos: Int) {
		parserData.getAllImages(searchTerms: "") { [weak self] (photos) in
			guard let photosResult = photos else { return }
			self?.array = photosResult.results
			self?.photoCollectionView.reloadData()
			//print(self!.array)
			
		}
	}
	
	private func setupSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		searchController.searchBar.delegate = self
	}
}

//MARK:  UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print(searchText)
		if searchBar.searchTextField.text!.count > 2 {
			parserData.getImages(searchTerms: searchText) { [weak self](photos) in
				guard let photosResults = photos else { return }
				self?.array = photosResults.results
				self?.photoCollectionView.reloadData()
				//print(self!.array)
				
//				func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//					return CGSize.init(width: self!.view.frame.width, height: self!.view.frame.height)
//				}
				
				
			}
		}
	}
	
}

//MARK:  UICollectionViewDelegate, UICollectionViewDataSource,
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return array.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CellPhoto", for: indexPath) as! PhotoViewCell
		let images = array[indexPath.item]
		cell.imageCell = images
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
		
		//performSegue(withIdentifier: "fullImage", sender: self)
		let fullPhotoView = storyboard?.instantiateViewController(withIdentifier: "FullPhotoView")
		navigationController?.pushViewController(fullPhotoView!, animated: true)
		
		collectionView.deselectItem(at: indexPath, animated: true)
		let images = array[indexPath.item]
		image.imageCell = images
		photoCollectionView.reloadData()
	}
	
	
}


//MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let photo = array[indexPath.item]
		let spasing = (countImageHeight + 1) * insetsImage.bottom
		let overallWidthCell = view.frame.height - spasing
		let heightCell = (overallWidthCell / countImageHeight) * 0.9
		let widthtCell = CGFloat(photo.width) * heightCell / CGFloat(photo.height)
		
		
		return CGSize.init(width: widthtCell, height: heightCell)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return insetsImage
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return insetsImage.bottom
	}
}

//MARK: UIScrollViewDelegate
//extension ViewController: UIScrollViewDelegate {
//		func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//		if (self.photoCollectionView.contentOffset.y >= (self.photoCollectionView.contentSize.height - self.photoCollectionView.bounds.size.height)) {
//
//			photo = photo + 3
//			allPhoto(photos: photo)
//
//		}
//	}
//
//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		let step = array.count / 10
//		if scrollView.contentSize.height >= scrollView.bounds.height {
//			scrollView.contentSize.height.
//		}
//
//
//
////		scrollView.contentOffset.y > array. {
////		scrollView.isScrollEnabled = false
////		scrollView.isScrollEnabled = true
////
//}
//	func setContentOffset(CGPoint, animated: Bool){
//
//	}
//
//}

