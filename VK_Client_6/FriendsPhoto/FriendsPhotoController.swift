//
//  FriendsPhotoController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit





class FriendsPhotoController: UICollectionViewController {

    var friendPhoto: Friend?
    var count = 0
    
    

    
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
        
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! FriendsPhotoCell
    
        if let friends = friendPhoto {
            if let url = URL(string: friends.photo50) {
                if let data = try? Data(contentsOf: url){
                    cell.friendImage.image =  UIImage(data: data)
                }
            }
        }
    
        //cell.friendImage.image = friendPhoto?.photo50
        
        return cell
    }

    
}
