//
//  PuzzleViewController.swift
//  Gridy
//
//  Created by Ellen Covey on 23/07/2019.
//  Copyright © 2019 Ellen Covey. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var targetBox: UIView!
    @IBOutlet weak var coverSpace: UIView!
    
    public var editedImage: UIImage? // for screenshot from last view
    let gridSize = 3
    
    // holds top left point of any moved tile
    var coordinates: CGPoint?
    var dropPoint: CGPoint?
    var tileDict: [Int:UIImage]? = [:]
    
    func getDropPoint() {
        // let cvPoint = collectionView.frame.origin  // error - this can unwrap to nil, find way to initialise properly
        let point = CGPoint(x: coordinates!.x + 16, y: coordinates!.y + 90) // numbers are temporary
        dropPoint = point
        print("The drop point is \(dropPoint!)")
    }
    
    func printLocation() {
        print(coordinates!)
    }
    
    func printPoints() {
        print("The blue view is at \(coverSpace.frame.origin)")
        print("The collection view is at \(collectionView.frame.origin)")
        print("The target box is at \(targetBox.frame.origin)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // making dictionary by splitting image
        
        printPoints()
        
        func getDict() -> [Int: UIImage]? {
            if let editedImage = editedImage {
                return editedImage.splitImage(gridSize)
            }
            return [:]
        }
        
        tileDict = getDict()
        
//        for (number, _) in tileDict! {
//            print("Tile number \(number)")
//        }
        
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

// print values in viewcontroller, check centre info is passing correctly

// when dropping - print boundaries of 2nd collection view
// write comparisons in viewcontroller, get info from class with delegates/delegate pattern
// use for loop to compare centres, stop if true & assign
// have isEmpty property, set to false once tile is correctly dropped there
// also try UIView divided mathematically into pieces & calculate centres
// tiles could be in table view
// if position correct, assign tile as content of cell in 2nd collection view

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
