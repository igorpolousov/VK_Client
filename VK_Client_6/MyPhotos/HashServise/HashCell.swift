//
//  HashCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 14.02.2022.
//

import UIKit

class HashCell: UITableViewCell {
    
    @IBOutlet var hashCellImage: UIImageView!
    @IBOutlet var hashCellDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hashCellImage.applyDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
