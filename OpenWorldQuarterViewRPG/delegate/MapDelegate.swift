//
//  MapDelegate.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/08.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class MapDelegate {
    var model:MapModel
    
    init (model:MapModel)
    {
        self.model = model
    }
    
    deinit {
        
    }
    
    func getModelNode() -> SKNode
    {
        return self.model.node
    }
    
    func getModelChipDictionary() -> Dictionary<String, ChipInfo>
    {
        return self.model.chipInfoDicionary
    }
    
    func setModelChipDictionary(let name:String, let info:ChipInfo)
    {
        self.model.chipInfoDicionary[name] = info
    }
    
    func setModelStart(start:Int)
    {
        self.model.startNo = start
    }
    
}