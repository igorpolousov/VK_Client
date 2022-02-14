//
//  HashBigImageViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 11.02.2022.
//

import UIKit

class HashBigImageViewController: UIViewController {
    
    var imageGet: UIImage?

    @IBOutlet var bigImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = imageGet {
            bigImage.image = imageToLoad
        }
    }

}
