//
//  UIScrollView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/1.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class CustomUIScrollView: UIView{
    
    var view:UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            let bannerCell = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
            self.collectionView.register(bannerCell, forCellWithReuseIdentifier: "ImageCollectionViewCell")
            let personCell = UINib(nibName: "PersonIntroCollectionViewCell", bundle: nil)
            self.collectionView.register(personCell, forCellWithReuseIdentifier: "PersonIntroCollectionViewCell")
        }
    }
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contentview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomUIScrollView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
