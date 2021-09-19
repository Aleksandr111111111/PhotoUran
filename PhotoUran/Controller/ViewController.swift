//
//  ViewController.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 09.09.2021.
//
import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var photoCollectionView: UICollectionView!
	var array = [FotoResult]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		photoCollectionView.delegate = self
		photoCollectionView.dataSource = self
		photoCollectionView.backgroundColor = .lightGray
		allPhoto()
		setupSearchBar()
	}
}

//MARK:  UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.searchTextField.text?.count ?? Constants().countSimbols > Constants().countSimbols {

			NetworkService().getSearchBarRequest(searchTerms: searchText){ [weak self](photo) in
				self?.array = photo
				self?.photoCollectionView.reloadData()
			}
		}
	}
}

//MARK:   UICollectionViewDataSource,
extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return array.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CellPhoto", for: indexPath) as! PhotoViewCell
		let images = array[indexPath.item]
		cell.imageCell = images
		return cell
	}
}

//MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
		let fullPhotoView = storyboard?.instantiateViewController(withIdentifier: "FullPhotoView") as! FullPhotoView
		navigationController?.pushViewController(fullPhotoView, animated: true)
		collectionView.deselectItem(at: indexPath, animated: true)
		let image = array[indexPath.item]
		fullPhotoView.imageCell = image
		photoCollectionView.reloadData()
	}
}

//MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let photo = array[indexPath.item]
		let spasing = (Constants().countImageHeight + Constants().countSpasing) * Constants().insetsImage.bottom
		let overallWidthCell = view.frame.height - spasing
		let heightCell = (overallWidthCell / Constants().countImageHeight) * Constants().sizePhotoForView
		let widthtCell = CGFloat(photo.width) * heightCell / CGFloat(photo.height)
		return CGSize.init(width: widthtCell, height: heightCell)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return Constants().insetsImage
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Constants().insetsImage.bottom
	}
}

//MARK: Private
private extension ViewController {
	private func allPhoto() {
		NetworkService().getFirstRequest { [weak self] photos in
			self?.array = photos
			self?.photoCollectionView.reloadData()
		}
	}
	
	private func setupSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		searchController.searchBar.delegate = self
	}
}
