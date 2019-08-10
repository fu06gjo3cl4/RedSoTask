//
//  PersonIntroCollectionViewCell.swift
//  TaskForRedSo
//
//  Created by 黃麒安 on 2019/8/10.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class PersonIntroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_position: UILabel!
    @IBOutlet weak var lb_expertise: UILabel!
    @IBOutlet weak var imageView_avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithPresenter(presenter: PersonCellViewModelPresenter){
        presenter.updateNameLable(label: lb_name)
        presenter.updatePositionLable(label: lb_position)
        presenter.updateExpertiseLable(lable: lb_expertise)
        presenter.updateAvatarImage(imageView: imageView_avatar)
    }
}



