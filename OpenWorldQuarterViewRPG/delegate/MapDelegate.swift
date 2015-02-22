//
//  MapDelegate.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/08.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

internal class MapDelegate {
    internal var model:MapModel
    
    init (model:MapModel)
    {
        self.model = model
    }
    
    deinit {
        
    }
    
    internal func getModelNode() -> SKNode
    {
        return self.model.node
    }
    
    internal func getModelScene() -> SKNode
    {
        return self.model.scene
    }
    
    internal func getModelNodes() -> [Node]
    {
        return self.model.nodes
    }
    
    internal func getModelHero() -> Avatar
    {
        return self.model.hero
    }
    
    internal func getModelChipDictionary() -> Dictionary<String, ChipInfo>
    {
        return self.model.chipInfoDicionary
    }
    
    internal func setModelChipDictionary(let name:String, let info:ChipInfo)
    {
        self.model.chipInfoDicionary[name] = info
    }
    
    internal func setModelStart(start:Int)
    {
        self.model.startNo = start
    }
    
    internal func onTouchCursor(direction:Int)
    {
        self.model.onTouchCursor(direction)
    }
    
}