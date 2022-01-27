//
//  AvatarNameDateCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 27.01.2022.
//

import UIKit

class AvatarNameDateCell: UITableViewCell {
    
    @IBOutlet var shadowView: ShadowView!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var date: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.applyDesign()
        shadowView.applyDesignShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
