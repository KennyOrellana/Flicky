//
//  PhotoDetailsViewController.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/15/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoDetailsViewController: UIViewController {

    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    var cards = [Photo]()
    var currentPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipedGestureRecognizer()
        refreshImage()
    }
    
    /*
     Gesture/Swipe
     */
    func setupSwipedGestureRecognizer() {
        addGestureRecognizerWithType(pressType: .leftArrow, selector: #selector(leftSelected))
        addGestureRecognizerWithType(pressType: .rightArrow, selector: #selector(rightSelected))
        addSwipeGestureRecognizerWithType(direction: .right, selector: #selector(rightSelected))
        addSwipeGestureRecognizerWithType(direction: .left, selector: #selector(leftSelected))
    }
    
    @objc func leftSelected(){
        currentPosition -= 1
        if(currentPosition < 0){
            currentPosition = 0
        } else {
            refreshImage()
        }
    }
     
    @objc func rightSelected(){
        currentPosition += 1
        if(currentPosition >= cards.count){
            currentPosition = cards.count - 1
        } else {
            refreshImage()
        }
    }
    
    func addGestureRecognizerWithType(pressType : UIPress.PressType, selector : Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tapGestureRecognizer.allowedPressTypes = [NSNumber(value: pressType.rawValue)]
        view.addGestureRecognizer(tapGestureRecognizer)
     }
     
    func addSwipeGestureRecognizerWithType(direction : UISwipeGestureRecognizer.Direction, selector : Selector) {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: selector)
        swipeGestureRecognizer.direction = direction
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    /*
     Image Loading
     */
    func refreshImage(){
        self.imageView.image = nil
        self.loadImage(cards[currentPosition].urlMedium!) //Load medium cached image
        self.loadImage(cards[currentPosition].urlLarge!) //Load large image
    }
    
    func loadImage(_ url: String){
        let urlImage = URL(string: url)!
        self.imageView.af.setImage(
            withURL: urlImage,
            imageTransition: .crossDissolve(0.2)
        )
    }
}
