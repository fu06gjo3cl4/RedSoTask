//
//  ContentViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/1.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ContentViewController: UIViewController{
    
    @IBOutlet weak var customView: CustomUIScrollView!
    
    var index = 0
    var team = ["rangers", "elastic", "dynamo"]
    var page = 0
    var personList: [PersonIntro] = [PersonIntro]()
    var isReadyForRequest = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ContentViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !personList.isEmpty{
            let person = personList[indexPath.row]
            
            if person.type == "employee"{
                let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonIntroCollectionViewCell", for: indexPath) as! PersonIntroCollectionViewCell
                let viewModel = PersonCellViewModel(personIntro: person)
                personCell.updateWithPresenter(presenter: viewModel)
                personCell.addbottomborder(view: personCell, color: UIColor.white.cgColor, height: 1)
                
                return personCell
            }else if person.type == "banner"{
                let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
                bannerCell.imageView.downloaded(from: person.url)
                bannerCell.imageView.contentMode = .scaleAspectFill
                bannerCell.imageView.frame = bannerCell.bounds
                bannerCell.imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
                return bannerCell
            }
        }
        
        let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonIntroCollectionViewCell", for: indexPath) as! PersonIntroCollectionViewCell
        return personCell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let person = personList[indexPath.row]
        var size: CGSize?
        if person.type == "banner"{
            size = CGSize(width: self.view.frame.width, height: self.view.frame.height/3)
        }else{
            size = CGSize(width: self.view.frame.width, height: self.view.frame.height/4)
        }
//        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height/4.5)
        return size!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.page)
        print(self.isReadyForRequest)
    }
    
}


extension ContentViewController{
    
    func getCatalog(){
        let parameters: Parameters = [
            "team":team[index],
            "page":page
        ]
        RestfulService.request_get(url: GetUrl.Url+ApiList.GetCatalogList, parameters: parameters, callback: getCatalogcallback)
    }
    
    func getCatalogcallback(json:JSON){
        print("callbackfunction was executive")
        print(json)
        
        if json.count == 0{
            reloadData()
        }else{
            for i in 0..<json.count{
                
                let person = PersonIntro()
                person.id = json[i]["id"].stringValue
                person.type = json[i]["type"].stringValue
                person.url = json[i]["url"].stringValue
                person.name = json[i]["name"].stringValue
                person.position = json[i]["position"].stringValue
                person.expertise = json[i]["expertise"].arrayValue.map {$0.stringValue}
                person.avatar = json[i]["avatar"].stringValue
                
                personList.append(person)
                if i == json.count-1{
                    reloadData()
                }
            }
        }
    }
    
    func reloadData(){
        self.customView.collectionView.reloadData()
        for constraint in self.customView.collectionView.constraints {
            if constraint.identifier == "heightOfCollectionView" {
                constraint.constant = self.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
        }
        for constraint in self.customView.scrollview.constraints{
            if constraint.identifier == "contentViewHeight"{
                constraint.constant = self.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
        }
        self.customView.layoutIfNeeded()
        page += 1
        isReadyForRequest = true
    }
    
    func reflashData(){
        self.page = 0
        self.personList = [PersonIntro]()
        getCatalog()
        
    }
    
}
