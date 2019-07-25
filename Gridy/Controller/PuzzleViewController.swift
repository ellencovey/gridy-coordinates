//
//  PuzzleViewController.swift
//  Gridy
//
//  Created by Ellen Covey on 23/07/2019.
//  Copyright © 2019 Ellen Covey. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var splitButton: UIButton!
    
    @IBAction func splitImage(_ sender: Any) {
        sliceImage()
    }
    
    // placeholder image for screenshot
    var editedImage = UIImage(named: "pic-ben")
    
    func sliceImage() {
        splitImage(row: 3, column: 3)
        createNewImage(imgArr: tileArr.shuffled())
    }
    
    var tileArr = [[UIImage]]() // will contain small pieces of image
    
    func splitImage(row : Int , column : Int) {
        
        let originalImg = myImage.image
        
        let tileHeight =  (myImage.image?.size.height)! / CGFloat (row)
        let tileWidth =  (myImage.image?.size.width)! / CGFloat (column)
        
        let scale = (myImage.image?.scale)! //scale conversion factor is needed as UIImage make use of "points" whereas CGImage use pixels.
        
        
        
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
    
    func createNewImage(imgArr: [[UIImage]]){
        
        let row = imgArr.count
        let column = imgArr[0].count
        let height =  (myImage.frame.size.height) /  CGFloat (row )
        let width =  (myImage.frame.size.width) / CGFloat (column )
        
        
        UIGraphicsBeginImageContext(CGSize.init(width: myImage.frame.size.width , height: myImage.frame.size.height))
        
        for y in 0..<row{
            
            for x in 0..<column{
                
                let newImage = imgArr[y][x]
                
                newImage.draw(in: CGRect.init(x: CGFloat(x) * width, y:  CGFloat(y) * height  , width: width - 1  , height: height - 1 ))
                
            }
        }
        
        let originalImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        myImage.image = originalImg
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myImage.image = editedImage
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
}
