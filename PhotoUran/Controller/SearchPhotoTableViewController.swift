//
//  SearchPhotoTableViewController.swift
//  PhotoUran
//
//  Created by Aleksander Kulikov on 24.09.2021.
//

import UIKit
import SDWebImage

class SearchPhotoTableViewController: UITableViewController {
	
	struct Constants {
		let countSimbols = 2
		let cellId = "SearchPhotoTable"
	}
	
	var arrayTableFoto = [URLModel]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchBar()
	}
	
	func setupSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "START YOUR SEARCH"
		searchController.searchBar.tintColor = .black
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.obscuresBackgroundDuringPresentation = false
		
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return arrayTableFoto.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants().cellId, for: indexPath) as! SearchPhotoViewCell
		
		cell.setupTabImage(model: arrayTableFoto[indexPath.row])
		return cell
	}
}

//MARK: DELETE
extension SearchPhotoTableViewController{
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			self.arrayTableFoto.remove(at: indexPath.row)
			self.tableView.beginUpdates()
			self.tableView.deleteRows(at: [indexPath], with: .automatic)
			self.tableView.endUpdates()
		} else if editingStyle == .insert {
		}
	}
}

//MARK:  UISearchBarDelegate
extension SearchPhotoTableViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
			guard let text = searchBar.searchTextField.text, text.count > Constants().countSimbols else { return }
		DispatchQueue.main.async {
			NetworkService().getRequest(searchTerms: searchText) { [weak self] (photos) in
				self?.arrayTableFoto =  photos.results
				self?.tableView.reloadData()
			}
		}
	}
}

/*
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

}
*/
/*
// Override to support conditional editing of the table view.
override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
// Return false if you do not want the specified item to be editable.
return true
}
*/

// Override to support editing the table view.

/*
// Override to support rearranging the table view.
override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

}
*/

/*
// Override to support conditional rearranging of the table view.
override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
// Return false if you do not want the item to be re-orderable.
return true
}
*/

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Get the new view controller using segue.destination.
// Pass the selected object to the new view controller.
}
*/




