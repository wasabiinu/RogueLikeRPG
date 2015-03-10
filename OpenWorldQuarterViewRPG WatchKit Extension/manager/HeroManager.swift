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
    
    internal class var mode:String
        {
        set {
        ClassProperty.mode = newValue
        }
        get {
            return ClassProperty.mode
        }
    }
    
    private struct ClassProperty {
        static var nextDirection:Int!
        static var hero:Avatar!
        static var mode:String = ""
    }
    
    internal class func setHero(avatar:Avatar)
    {
        self.hero = avatar
    }
    
    internal class func getHero() -> Avatar
    {
        return self.hero
    }
    
    internal class func setNextDirection(direction:Int)
    {
        self.nextDirection = direction
    }
    
    internal class func getNextDirection() -> Int
    {
        return self.nextDirection
    }
    
    internal class func onTouchCursor(direction:Int)
    {
        self.mode = "move"
    }
    
    internal class func onTouchAttack()
    {
        self.mode = "attack"
    }
    
    internal class func action(callback:Void -> Void, option:[AnyObject])
    {
        switch self.mode
        {
        case "move":
            moveHero(callback, option: option)
            break
        case "attack":
            attackHero(callback, option: option)
            break
        default:
            moveHero(callback, option: option)
            break
        }
    }
    
    internal class func moveHero(callback:Void -> Void, option:[AnyObject])
    {
        UIUtil.delegate.moveHero(callback, option: option)
    }
    
    internal class func attackHero(callback:Void -> Void, option:[AnyObject])
    {
    }
}
