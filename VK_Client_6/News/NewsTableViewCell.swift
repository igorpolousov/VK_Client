//
//  NewsTableViewCell.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var tapCounter: UILabel!
    @IBAction func likeButton(_ sender: Any) {
        heartOn = !heartOn
        updateHeart()
        tapCounter.text = "\(tapCount)"
    }
    
    @IBOutlet weak var heartImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendImage.applyDesign()
        shadowView.applyDesignShadow()
        heartImage.tintColor = UIColor.systemBlue
        heartImage.image = UIImage.init(systemName: "heart")
        tapCounter.textColor = UIColor.systemBlue
        tapCounter.text = "0"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
