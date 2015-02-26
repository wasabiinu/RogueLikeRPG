//
//  HeroManager.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/26.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class HeroManager
{
    init()
    {
        
    }
    
    internal class var nextDirection:Int
        {
        set {
        ClassProperty.nextDirection = newValue
        }
        get {
            return ClassProperty.nextDirection
        }
    }
    
    internal class var hero:Avatar
        {
        set {
        ClassProperty.hero = newValue
        }
        get {
            return ClassProperty.hero
        }
    }
    
    private struct ClassProperty {
        static var nextDirection:Int!
        static var hero:Avatar!
    }
    
    internal class func onTouchCursor(direction:Int)
    {
        
    }
    
    internal class func onTouchAttack()
    {
        
    }
}
