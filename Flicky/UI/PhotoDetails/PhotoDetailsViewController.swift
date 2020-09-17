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
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.imageView.image = image
                self.spinner.stopAnimating()
            }
        }
    }
}
