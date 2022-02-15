//
//  HashWOXibCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 15.02.2022.
//

import UIKit

class HashWOXibCell: UITableViewCell {

   
    @IBOutlet var hashView: ShadowView!
    @IBOutlet var hashLabel: UILabel!
    @IBOutlet var hashImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
