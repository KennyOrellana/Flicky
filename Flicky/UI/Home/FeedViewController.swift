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

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var cards = [Photo]()
    var totalPages = 1
    var lastPage = 0
    var loadingNexPage = false
    var timer: Timer?
    var queryString: String = ""
    
    /*
    UIViewController
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    /*
     UICollectionViewDataSource
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { fatalError("Couldn't dequeue a cell")}
        let cardItem = cards[indexPath.row]
        cell.setData(cardItem)
    
        checkIfRequirePagination(position: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? Header{
            if(!queryString.isEmpty){
                if( self.cards.count == 0){
                    header.label.text = "No search results for \"\(queryString)\""
                } else {
                    header.label.text = "Search results for \"\(queryString)\""
                }
            } else {
                header.label.text = Strings.HomeHeader
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    /*
     UICollectionViewDelegate
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PhotoDetail") as? PhotoDetailsViewController else { return }
        vc.cards = cards
        vc.currentPosition = indexPath.row
        present(vc, animated: true)
    }
    
    /*
     UISearchResultsUpdating
     */
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        timer?.invalidate()
        
        if(text.isEmpty){
            if(!queryString.isEmpty){ //User deleted search
                lastPage = 0
                requestData()
            }
        } else if(text != queryString){ //Search when current query is different fron last requested
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
                timer.invalidate()
                self.search(text)
            }
        }
    }
    
    /*
     Data Loading and Search
     */
    func checkIfRequirePagination(position: Int){
        if(position + 9 > cards.count && lastPage < totalPages && !loadingNexPage){
            if(queryString.isEmpty){
                requestData()
            } else {
                search(queryString)
            }
        }
    }
    
    func requestData() {
        if(lastPage < totalPages && !loadingNexPage){
            loadingNexPage = true
            
            let requestPage = lastPage + 1 //Using local var to not modify last loaded page until new data arrives
        
            if(cards.isEmpty){ //Show progress bar only when screen is empty
                self.spinner.startAnimating()
                self.spinner.alpha = 1
            }
            
            APIManager.getFeed(page: requestPage).response { response in
                if(response.data != nil){
                    self.queryString = ""
                    self.presentData(response.data!)
                }  else if(self.cards.isEmpty){
                    self.showError()
                }
            }
        }
    }
    
    func search(_ queryString: String){
        if(queryString != self.queryString || queryString == self.queryString && lastPage < totalPages && !loadingNexPage){//Request search when query changed or is the same but reached last items
            loadingNexPage = true
            
            var requestPage = 1 //Using local var to not modify last loaded page until new data arrives
            if(queryString == self.queryString){ //If it's the same search, request next page, if not request first page
                requestPage = lastPage + 1
            }
                
            if(cards.isEmpty){ //Show progress bar only when screen is empty
                self.spinner.startAnimating()
                self.spinner.alpha = 1
            }
            
            APIManager.search(page: requestPage, queryString).response { response in
                if(response.data != nil){
                    self.tabBarController?.selectedIndex = 0
                    self.queryString = queryString
                    self.presentData(response.data!)
                } else {
                    self.showError()
                }
            }
        }
    }
    
    func presentData(_ data: Data) {
        let feed = try? JSONDecoder().decode(Feed.self, from: data)

        if(lastPage == 1){ //Only clear list when it's loading from page 1
            self.cards.removeAll()
        }
        feed?.photos.photo.forEach({
            if($0.urlLarge != nil && $0.urlMedium != nil && !$0.title.isEmpty){
               self.cards.append($0)
            }
        })

        if(feed != nil){
            self.totalPages = feed!.photos.pages
            self.lastPage = feed!.photos.page
            loadingNexPage = false
        }
        
        self.spinner.stopAnimating()
        self.spinner.alpha = 0
        self.collectionView.reloadData()
    }
    
    func showError(){
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong :(", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Retry", comment: "Default action"),
                style: .default, handler: { _ in
                    if(self.queryString.isEmpty){
                        self.requestData()
                    } else {
                        self.search(self.queryString)
                    }
                }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Exit", comment: ""),
                style: .default, handler: { _ in
                    exit(0)
                }
            )
        )
        
        self.present(alert, animated: true, completion: nil)
    }
}
