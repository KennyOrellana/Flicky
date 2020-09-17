//
//  FirstViewController.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/15/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var cards = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Card", for: indexPath)
        cell.textLabel?.text = cards[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PhotoDetail") as? PhotoDetailsViewController else { return }
        
        vc.url = cards[indexPath.row].urlLarge!
    
        present(vc, animated: true)
    }
    
    func requestData(){
        APIManager.getFeed().response { response in
                   if(response.data != nil){
                       let feed = try? JSONDecoder().decode(Feed.self, from: response.data!)
                   
                       feed?.photos.photo.forEach({
                           if($0.urlLarge != nil && $0.urlMedium != nil && !$0.title.isEmpty){
                               self.cards.append($0)
                           }
                       })
                       
                       self.tableView.reloadData()
                   }
        }
    }
}

