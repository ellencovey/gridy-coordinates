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
    @IBOutlet weak var targetCollection: UICollectionView!
    @IBOutlet weak var coverSpace: UIView!
    
    public var editedImage: UIImage? // for screenshot from last view
    let gridSize = 4
    let sandColor = UIColor(red: 241.00/255.00, green: 233.00/255.00, blue: 212.00/255.00, alpha: 1.00)
    
    var tileDict: [Int:UIImage]? = [:]
    var draggedTile: UIView? // dragged tile passed from class
    var coordinates: CGPoint? // top left point of dragged tile
    var dropPoint: CGPoint? // calculated top left point of dragged tile in screen
    var tileCenter: CGPoint?
    
    // empty dictionary for second collection view
    var blankDict: [Int:UIImage] = [0:UIImage(), 1:UIImage(), 2:UIImage(), 3:UIImage(), 4:UIImage(), 5:UIImage(), 6:UIImage(), 7:UIImage(), 8:UIImage(), 9:UIImage(), 10:UIImage(), 11:UIImage(), 12:UIImage(), 13:UIImage(), 14:UIImage(), 15:UIImage(), 16:UIImage()]
    
    let cell0Center = CGPoint(x: 60, y: 353.5)
    let cell1Center = CGPoint(x: 145, y: 353.5)
    let cell2Center = CGPoint(x: 230, y: 353.5)
    let cell3Center = CGPoint(x: 315, y: 353.5)
    let cell4Center = CGPoint(x: 60, y: 438.5)
    let cell5Center = CGPoint(x: 145, y: 438.5)
    let cell6Center = CGPoint(x: 230, y: 438.5)
    let cell7Center = CGPoint(x: 315, y: 438.5)
    let cell8Center = CGPoint(x: 60, y: 523.5)
    let cell9Center = CGPoint(x: 145, y: 523.5)
    let cell10Center = CGPoint(x: 230, y: 523.5)
    let cell11Center = CGPoint(x: 315, y: 523.5)
    let cell12Center = CGPoint(x: 60, y: 608.5)
    let cell13Center = CGPoint(x: 145, y: 608.5)
    let cell14Center = CGPoint(x: 230, y: 608.5)
    let cell15Center = CGPoint(x: 315, y: 608.5)
    
    func getDropPoint() {
        // let cvPoint = collectionView.frame.origin  // error - this can unwrap to nil, find way to initialise properly
        let point = CGPoint(x: coordinates!.x + 16, y: coordinates!.y + 90) // numbers are temporary
        dropPoint = point
        print("Drop point: \(dropPoint!)")
    }
    
    func getTileCenter() {
        let tileSize = draggedTile?.frame.width
        let centerPoint = CGPoint(x: dropPoint!.x + (tileSize! / 2), y: dropPoint!.y + (tileSize! / 2))
        print("Tile size: \(tileSize!) by \(draggedTile!.frame.height)")
        print("Tile centre: \(centerPoint)")
        tileCenter = centerPoint
    }
    
    
    
    func compareLocations() { // temp numbers for target cell centres
        if hypot((tileCenter!.x - cell0Center.x), tileCenter!.y - cell0Center.y) <= 60.15 {
            print("Yes")
        }
        else {
            print("No")
        }
        
//        if dropPoint!.x <= targetCollection.frame.origin.x {
//            print("Correct")
//        }
//        else {
//            print("Wrong")
//        }
    }
    
    func printLocation() { // temp
        print("Coordinates:\(coordinates!)")
    }
    
    func printPoints() { // temp
        print("The blue view is at \(coverSpace.frame.origin)")
        print("The first collection view is at \(collectionView.frame.origin)")
        print("The target collection view is at \(targetCollection.frame.origin)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        printPoints() // temp
        
        // making dictionary by splitting image
        func getDict() -> [Int: UIImage]? {
            if let editedImage = editedImage {
                return editedImage.splitImage(gridSize)
            }
            return [:]
        }
        
        tileDict = getDict()
        
        // temp
        //        for (number, _) in tileDict! {
        //            print("Tile number \(number)")
        //        }
        
    }
    
    // configuring collection views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileDict!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == targetCollection) {
            let blankCell = targetCollection.dequeueReusableCell(withReuseIdentifier: "DropCell", for: indexPath) as! CollectionViewCellDrop
            blankCell.blankImageView.image = blankDict[indexPath.item]
            blankCell.layer.borderWidth = 1
            blankCell.layer.borderColor = sandColor.cgColor
            return blankCell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.tileImageView.image = tileDict![indexPath.item]
            return cell
        }
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
