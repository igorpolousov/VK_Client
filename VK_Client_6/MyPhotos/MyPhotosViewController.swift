//
//  MyPhotosViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 18.12.2021.
//

import UIKit


class MyPhotosViewController: UICollectionViewController {
    
    var images = [UIImage]()
    var imageGet: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = imageGet {
            images.append(imageToLoad)
        }
        
    }
    
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myPhotos", for: indexPath) as! MyPhotosViewCell
    
        cell.imageCell.image = images[indexPath.item]
    
        return cell
    }

    
}
