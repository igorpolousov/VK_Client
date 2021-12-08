//
//  FriendsPhotoController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit





class FriendsPhotoController: UICollectionViewController {

    var friendPhoto: Friend?
    
    

    
    //private let reuseIdentifier = "PhotoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FriendsPhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")

        }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (friendPhoto?.pic.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! FriendsPhotoCell
    
        //let friendPhoto = genaPhotos[indexPath.item]
    
        cell.friendImage.image = friendPhoto?.pic[indexPath.row]
        
        return cell
    }

    
}
