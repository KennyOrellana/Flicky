//
//  CollectionViewCell.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/17/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gradient: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var title: UILabel!
    @IBOutlet var info: UILabel!
    
    func viewAnimation(view:UIView , isNormal:Bool) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            if(isNormal) {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            } else {
                view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2);
            }

        })
        { (finished) -> Void in

        }
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if(context.previouslyFocusedView != nil) {
            if (context.previouslyFocusedView is CollectionViewCell) {
                let cell:CollectionViewCell = context.previouslyFocusedView as! CollectionViewCell
                cell.imageView.layer.borderWidth = 1
                cell.imageView.layer.borderColor = UIColor.lightGray.cgColor
                self.viewAnimation(view: cell.imageView, isNormal: true)
                self.viewAnimation(view: cell.gradient, isNormal: true)
                self.viewAnimation(view: cell.title, isNormal: true)
                self.viewAnimation(view: cell.info, isNormal: true)
            }
        }
        
        if(context.nextFocusedView != nil) {
            if (context.nextFocusedView is CollectionViewCell) {
                let cell:CollectionViewCell = context.nextFocusedView as! CollectionViewCell
                cell.imageView.layer.borderWidth = 3
                cell.imageView.layer.borderColor = UIColor.white.cgColor
                self.viewAnimation(view: cell.imageView, isNormal: false)
                self.viewAnimation(view: cell.gradient, isNormal: false)
                self.viewAnimation(view: cell.title, isNormal: false)
                self.viewAnimation(view: cell.info, isNormal: false)
            }
        }
    }
}
