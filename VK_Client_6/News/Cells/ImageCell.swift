//
//  ImageCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 27.01.2022.
//

import UIKit

class ImageCell: UITableViewCell {
    
    
    @IBOutlet var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
