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
    
    @IBOutlet var commentsCounter: UILabel!
    @IBAction func likeButton(_ sender: Any) {
    }
    
    @IBAction func commentTapped(_ sender: Any) {
    }
    
    @IBOutlet var comments: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comments.tintColor = .systemBlue
        comments.image = UIImage.init(systemName: "bubble.right")
        commentsCounter.tintColor = .systemBlue
        commentsCounter.text = "0"
        heartImage.tintColor = .systemRed
        heartImage.image = UIImage.init(systemName: "heart")
        heartsCounter.textColor = .systemRed
        heartsCounter.text = "0"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
