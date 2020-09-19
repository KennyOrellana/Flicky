//
//  FirstViewController.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/15/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var cards = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { fatalError("Couldn't dequeue a cell")}
        let cardItem = cards[indexPath.row]
        cell.spinner.startAnimating()
        cell.spinner.alpha = 1
        cell.imageView.image = nil
        cell.imageView.layer.borderColor = UIColor.white.cgColor

        let url = URL(string: cardItem.urlMedium!)!
        cell.imageView.af.setImage(
            withURL: url,
            imageTransition: .crossDissolve(0.2),
            completion: { response in
                cell.spinner.stopAnimating()
                cell.spinner.alpha = 0
                
                if(response.error != nil){
                    cell.imageView.image = UIImage(named: "image_not_found")
                }
            }
        )
        
        cell.title.text = cardItem.title
        let info = "\(cardItem.ownername) / \(cardItem.getDateFormated())"
        cell.info.text = info

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PhotoDetail") as? PhotoDetailsViewController else { return }
        vc.url = cards[indexPath.row].urlLarge!
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? Header{
            header.label.text = Strings.HomeHeader
            return header
        }
        return UICollectionReusableView()
    }
    
    func setupUI(){
        self.spinner.startAnimating()
    }
    
    func requestData() {
        APIManager.getFeed().response { response in
            if(response.data != nil){
                let feed = try? JSONDecoder().decode(Feed.self, from: response.data!)

                feed?.photos.photo.forEach({
                   if($0.urlLarge != nil && $0.urlMedium != nil && !$0.title.isEmpty){
                       self.cards.append($0)
                   }
                })

                self.spinner.stopAnimating()
                self.spinner.alpha = 0
                self.collectionView.reloadData()
           }
        }
    }
}
