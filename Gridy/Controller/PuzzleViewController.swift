//
//  PuzzleViewController.swift
//  Gridy
//
//  Created by Ellen Covey on 23/07/2019.
//  Copyright © 2019 Ellen Covey. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var editedImage = UIImage(named: "pic-ben") // placeholder image for screenshot from last view
    var tileArr = [[UIImage]]() // will contain small pieces of image
    lazy var tileImages = tileArr.reduce([], +) // this will pass to collection view
    
    // to do - split into single dictionary Int & UIImage, not array of arrays
    func splitImage(row : Int , column : Int) {
        
        let originalImg = editedImage
        
        let tileHeight = (editedImage?.size.height)! / CGFloat (row)
        let tileWidth = (editedImage?.size.width)! / CGFloat (column)
        let scale = (editedImage?.scale)!
        
        for y in 0 ..< row {
            var yArr = [UIImage]()
            for x in 0 ..< column {
                UIGraphicsBeginImageContextWithOptions(CGSize(width: tileWidth, height: tileHeight), false, 0) // size, opaque, scale
                let i =  originalImg?.cgImage?.cropping(to:  CGRect.init(x: CGFloat(x) * tileWidth * scale, y: CGFloat(y) * tileHeight * scale, width: tileWidth * scale, height: tileHeight * scale) )
                let newImg = UIImage.init(cgImage: i!)
                
                yArr.append(newImg)
                
                UIGraphicsEndImageContext();
                
            }
            let shuffledYArr = yArr.shuffled()
            tileArr.append(shuffledYArr)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        splitImage(row: 3, column: 3)
    }
    
    // configuring collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.tileImageView.image = tileImages[indexPath.item]
        return cell
    }
    
    
    
}
