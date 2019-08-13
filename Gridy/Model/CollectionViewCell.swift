//
//  CollectionViewCell.swift
//  Gridy
//
//  Created by Ellen Covey on 27/07/2019.
//  Copyright © 2019 Ellen Covey. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tileImageView: UIImageView!
    
    let vc = PuzzleViewController()
    var initialImageViewOffset = CGPoint()

    // assigning pan gesture to drag tiles
    override func awakeFromNib() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveImage(_:)))
        panGesture.delegate = self
        tileImageView.isUserInteractionEnabled = true
        tileImageView.addGestureRecognizer(panGesture)
    }
    
//    @objc func moveImage(_ sender: UIPanGestureRecognizer) {
//        sender.view?.superview?.bringSubviewToFront(sender.view!)
//        let translation = sender.translation(in: sender.view?.superview)
//        if sender.state == .began {
//            initialImageViewOffset = (sender.view?.frame.origin)!
//        }
//        let position = CGPoint(x: translation.x + initialImageViewOffset.x - (sender.view?.frame.origin.x)!, y: translation.y + initialImageViewOffset.y - (sender.view?.frame.origin.y)!)
//        let postionInSuperView = sender.view?.convert(position, to: sender.view?.superview)
//        sender.view?.transform = (sender.view?.transform.translatedBy(x: position.x, y: position.y))!
//        //        if sender.state == .ended {
//        //            let (nearTile, snapPosition) = isTileNearGrid(droppingPosition: postionInSuperView!)
//        //            let t = sender.view as! TileAttributes
//        //            if nearTile {
//        //                sender.view?.frame.origin = gridLocations[snapPosition]
//        //                if soundButton.isSelected != true {
//        //                    play(sound: "correct")
//        //                }
//        //                if String(snapPosition) == t.accessibilityLabel {
//        //                    t.isTileInCorrectLocation = true
//        //                } else {
//        //                    t.isTileInCorrectLocation = false
//        //                }
//        //            } else {
//        //                sender.view?.frame.origin = t.originalTileLocation
//        //                t.isTileInCorrectLocation = false
//        //                if soundButton.isSelected != true {
//        //                    play(sound: "wrong")
//        //                }
//        //            }
//        //            checkIfGameComplete()
//        //        }
//    }
    
    // called when dragging tile from first collection view
    @objc func moveImage(_ sender: UIPanGestureRecognizer) -> CGPoint {
        
        let chosenTile = sender.view
        let space = chosenTile?.superview
        
        // bring cell to top of everything else
        self.superview?.bringSubviewToFront(self)
        
        // the x and y position relative to where tile started
        let translation = sender.translation(in: space)
        
        if sender.state == .began {
            initialImageViewOffset = (chosenTile?.frame.origin)!
            // initialImageViewOffset = (chosenTile?.convert(frame.origin, to: chosenTile?.superview))! // position in superview
        }
        
        let position = CGPoint(x: translation.x + initialImageViewOffset.x - (chosenTile?.frame.origin.x)!, y: translation.y + initialImageViewOffset.y - (chosenTile?.frame.origin.y)!)
        let positionInSuperView = (chosenTile?.convert(frame.origin, to: space))
        chosenTile?.transform = (chosenTile?.transform.translatedBy(x: position.x, y: position.y))!
        
        if sender.state == .ended {
            chosenTile?.frame.origin = initialImageViewOffset
            vc.coordinates = positionInSuperView
            vc.printLocation()
            vc.getDropPoint()
        }
        
        return positionInSuperView!
    }
    
}
