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
	
    override func awakeFromNib() {
        super.awakeFromNib()
         //Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

	func setupTabImage(model: FotoModel?){
		guard let imageUrl = model?.urls.small, let url = URL(string: imageUrl) else { return }
		searchPhotoCell?.sd_setImage(with: url, completed: nil)
	}
}
