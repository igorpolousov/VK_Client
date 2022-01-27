//
//  LikesAndCommentsCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 27.01.2022.
//

import UIKit

class LikesAndCommentsCell: UITableViewCell {
    
    @IBOutlet var heartImage: UIImageView!
    
    @IBOutlet var heartsCounter: UILabel!
    
    @IBAction func likeButton(_ sender: Any) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
