//
//  MyPhotosTableViewCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 17.01.2022.
//

import UIKit

class MyPhotosTableViewCell: UITableViewCell {
 

    @IBOutlet var imagePhotoLoad: UIImageView!
    @IBOutlet var imagePhoto: ShadowView!
    @IBOutlet var imageTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePhoto.applyDesignShadow()
        imagePhotoLoad.applyDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
