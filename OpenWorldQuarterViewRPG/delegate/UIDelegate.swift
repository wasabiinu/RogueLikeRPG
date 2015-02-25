//
//  UIDelegate.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/12.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class UIDelegate {
    var model:UIModel;
    var scene:SKScene
    
    init (model:UIModel, scene:SKScene)
    {
        self.model = model
        self.scene = scene
    }
    
    deinit {
        
    }
    
    internal func getModelNode() -> SKNode
    {
        return self.model.node
    }
    
    internal func getModelScene() -> SKScene
    {
        return self.model.scene
    }
    
    internal func getModelLock() -> Bool
    {
        return self.model.lock
    }
    
    internal func setModelLock(v:Bool)
    {
        self.model.lock = v
    }
    
    internal func moveHero(callback:Void -> Void, option:[AnyObject])
    {
        println("UIDelegate::moveHero")
        self.model.moveHero(callback, option: option)
    }
}