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
    
    deinit {
        delegate  = nil
        chipInfoDicionary = Dictionary<String, ChipInfo>()
    }
    
    func afterInit()
    {
        //デリゲートを作る
        delegate = MapDelegate(model: self)
        //ユーティリティにデリゲートを渡す
        MapUtil.setDelegate(delegate)
        //マップを2分割法で作成する
        MapUtil.repeatSplitRectangle()
        //描画する
        MapUtil.draw()
    }
}