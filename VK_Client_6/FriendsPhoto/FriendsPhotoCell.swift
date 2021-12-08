//
//  FriendsPhotoCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit

class FriendsPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBAction func likeButton(_ sender: Any) {
        heartOn = !heartOn
        updateHeart()
        tapCounter.text = "\(tapCount)"
    }
    @IBOutlet weak var tapCounter: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heartImage.tintColor = UIColor.systemBlue
        heartImage.image = UIImage.init(systemName: "heart")
        tapCounter.textColor = UIColor.systemBlue
        tapCounter.text = "0"
        friendImage.layer.cornerRadius = 10
        friendImage.layer.borderWidth = 1
        friendImage.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    var heartOn = true
    var tapCount = 0
    
    func updateHeart(){
        if heartOn {
            heartImage.tintColor = UIColor.systemBlue
            heartImage.image = UIImage.init(systemName: "heart")
            tapCounter.textColor = UIColor.systemBlue
            tapCount -= 1
            
        } else {
            heartImage.tintColor = UIColor.systemPink
            heartImage.image = UIImage.init(systemName: "heart.fill")
            tapCounter.textColor = UIColor.systemPink
            tapCount += 1
            
        }
    }

}
