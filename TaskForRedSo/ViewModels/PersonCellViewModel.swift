//
//  PersonCellViewModel.swift
//  TaskForRedSo
//
//  Created by 黃麒安 on 2019/8/10.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit


class PersonCellViewModel : PersonCellViewModelPresenter {
    var name:String
    var position:String
    var expertises:[String]
    var avatar_imageUrl:String

    
    init(personIntro :PersonIntro){
        name = personIntro.name
        position = personIntro.position
        expertises = personIntro.expertise
        avatar_imageUrl = personIntro.avatar
    }
    
    func updateNameLable(label:UILabel){
        label.text = name
    }
    func updatePositionLable(label:UILabel){
        label.text = position
    }
    func updateExpertiseLable(lable:UILabel){
        var text = ""
        for i in 0..<expertises.count{
            if i == expertises.count-1{
                text.append(expertises[i])
            }else{
                text.append(expertises[i]+", ")
            }
        }
        lable.text = text
    }
    func updateAvatarImage(imageView:UIImageView){
        imageView.downloadedForCircleMasked(from: avatar_imageUrl)
    }
}

protocol PersonCellViewModelPresenter {
    var name:String{get}
    var position:String{get}
    var expertises:[String]{get}
    var avatar_imageUrl:String{get}
    
    func updateNameLable(label:UILabel)
    func updatePositionLable(label:UILabel)
    func updateExpertiseLable(lable:UILabel)
    func updateAvatarImage(imageView:UIImageView)
}

//
//@IBOutlet weak var lb_name: UILabel!
//@IBOutlet weak var lb_position: UILabel!
//@IBOutlet weak var lb_expertise: UILabel!
//@IBOutlet weak var imageView_avatar: UIImageView!
//
