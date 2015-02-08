//
//  MapModel.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/08.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
import SpriteKit

class MapModel {
    var delegate:MapDelegate!
    var node:SKNode
    var chipInfoDicionary:Dictionary<String, ChipInfo> = Dictionary<String, ChipInfo>()
    
    init (node:SKNode)
    {
        println("MapModel::init")
        self.node = node
        afterInit()
    }
    
    func afterInit()
    {
        delegate = MapDelegate(model: self)
        MapUtil.setDelegate(delegate)
        MapUtil.repeatSplitRectangle()
        MapUtil.draw()
    }
}