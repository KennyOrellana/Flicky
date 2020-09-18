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
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImage()
    }
    
    func loadImage(){
        let urlImage = URL(string: url)!
        self.imageView.af.setImage(withURL: urlImage, imageTransition: .crossDissolve(0.2))
    }
}
