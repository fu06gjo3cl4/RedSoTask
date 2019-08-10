//
//  Const.swift
//  TaskForRedSo
//
//  Created by 黃麒安 on 2019/8/10.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit


class Const {
    static let Screen_Size = UIScreen.main.bounds
    static var Screen_Width: CGFloat{
        get{
            if Screen_Size.height > Screen_Size.width{
                return Screen_Size.width
            }else{
                return Screen_Size.height
            }
        }
    }
    
    static var Screen_Height: CGFloat{
        get{
            if Screen_Size.height > Screen_Size.width{
                return Screen_Size.height
            }else{
                return Screen_Size.width
            }
        }
    }
    
}
