//
//  PersonalQualityViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/4/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import Alamofire
import SwiftyJSON

class SwipeableViewController: UIViewController {
    
    static let shared = SwipeableViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    
    var array = ["Rangers", "Elastic", "Dynamo"]
    private var lastContentOffset: CGFloat = 0
    private var tapPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var viewControllers = [ContentViewController]()
    private var executeCount = 0
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set label Attribute
        let myMutableString = NSMutableAttributedString(string: "RedSo", attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:3,length:2))
        lb_title.attributedText = myMutableString
        
        //swipe menu
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        var options: SwipeMenuViewOptions = .init()
        options.tabView.itemView.textColor = UIColor.gray
        options.tabView.itemView.selectedTextColor = UIColor.white
        options.tabView.itemView.font = UIFont.boldSystemFont(ofSize: 18)
        options.tabView.itemView.margin = 20
        options.tabView.additionView.underline.height = 4
        options.tabView.additionView.backgroundColor = UIColor.red
        swipeMenuView.reloadData(options: options)
        swipeMenuView.tintColor = UIColor.red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var index = 0
        for vc in viewControllers{
            vc.index = index
            index += 1
            vc.customView.collectionView.dataSource = vc
            vc.customView.collectionView.delegate = vc
            vc.getCatalog()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SwipeableViewController: SwipeMenuViewDataSource {
    
    //MARK - SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return array.count
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return array[index]
    }
    
    //will call twice, a bug still alive with SwipeMenuViewController, this is a temporary solution
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        executeCount += 1
        
        if executeCount < array.count+1{
            return UIViewController()
        }else{
            let vc = ContentViewController()
            let customView = CustomUIScrollView(frame: vc.view.bounds)
            customView.scrollview.delegate = self
            vc.customView = customView
            vc.view.addSubview(vc.customView!)
            
            self.viewControllers.append(vc)
            print(viewControllers.count)
            return vc
        }
    }
}

extension SwipeableViewController: SwipeMenuViewDelegate {
    
    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
}

extension SwipeableViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let vc = self.viewControllers[swipeMenuView.currentIndex]
        
        print(self.tapPoint.y)
        print(scrollView.contentOffset)
        
        if (self.tapPoint.y > scrollView.contentOffset.y+120){
            print("is reflashing")
            
            if vc.isReadyForRequest{
                vc.isReadyForRequest = false
                vc.reflashData()
            }
        }
        else if (self.tapPoint.y < scrollView.contentOffset.y) {
            print("swipe_up")
            
            if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height - 300)){
                
                if(vc.page < 3 && vc.isReadyForRequest){
                    vc.isReadyForRequest = false
                    vc.getCatalog()
                }
            }
            
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("scrollViewDidScrollToTop")
    }
    
}

