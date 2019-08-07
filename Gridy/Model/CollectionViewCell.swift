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
    
    var initialImageViewOffset = CGPoint()

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
    

    @objc func moveImage(_ sender: UIPanGestureRecognizer) -> CGPoint {
        sender.view?.superview?.bringSubviewToFront(sender.view!)
        let translation = sender.translation(in: sender.view?.superview)
        
        if sender.state == .began {
            initialImageViewOffset = (sender.view?.frame.origin)!
        }
        
        let position = CGPoint(x: translation.x + initialImageViewOffset.x - (sender.view?.frame.origin.x)!, y: translation.y + initialImageViewOffset.y - (sender.view?.frame.origin.y)!)
        let positionInSuperView = sender.view?.convert(position, to: sender.view?.superview)
        sender.view?.transform = (sender.view?.transform.translatedBy(x: position.x, y: position.y))!
        
        if sender.state == .ended {
            print(positionInSuperView)
            sender.view?.frame.origin = initialImageViewOffset // if placement is wrong
            
        }
        
        return positionInSuperView!
    }
    
}
