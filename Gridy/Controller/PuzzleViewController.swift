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
    
    public var editedImage: UIImage? // placeholder image for screenshot from last view
    
    // making dictionary by splitting image
    func getDict() -> [Int: UIImage]? {
        if let editedImage = editedImage {
            return editedImage.splitImage(3)
        }
        return nil
    }

    lazy var tileDict = getDict()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for (number, tile) in tileDict! {
            print("Tile number \(number)")
        }
        
    }
    
    // configuring collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileDict!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.tileImageView.image = tileDict![indexPath.item]
        return cell
    }
    
    
    
}


// for every cell in 2nd collection view, cell.frame.contains (returns boolean) - check if location matches dragged cell (can get location from drag gesture) then check order & see if number matches (also dont allow if not within grid view at all)
// match piece centre with cell centre if correct
//
//@available(iOS 2.0, *)
//public func contains(_ rect2: CGRect) -> Bool
//
//
//@available(iOS 2.0, *)
//public func intersects(_ rect2: CGRect) -> Bool
//
//
//@available(iOS 2.0, *)
//public func contains(_ point: CGPoint) -> Bool
