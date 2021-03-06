//
//  MapModel.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/08.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
import SpriteKit

internal class MapModel {
    internal var delegate:MapDelegate!
    internal var node:SKNode
    internal var scene:SKNode
    internal var nodes:[Node]
    internal var startNo:Int
    //internal var hero:Avatar
    //internal var heroNextDirection:Int
    internal var chipInfoDicionary:Dictionary<String, ChipInfo> = Dictionary<String, ChipInfo>()
    
    init (node:SKNode, scene:SKNode)
    {
        println("MapModel::init")
        self.node = node
        self.nodes = [Node]()
        self.startNo = 0
        HeroManager.setHero(TestHero())
        HeroManager.setNextDirection(0)
        
        self.scene = scene
        
        afterInit()
    }
    
    deinit {
        delegate  = nil
        chipInfoDicionary = Dictionary<String, ChipInfo>()
    }
    
    internal func onTouchCursor(direction:Int)
    {
        HeroManager.setNextDirection(direction)
    }
    
    private func afterInit()
    {
        //デリゲートを作る
        delegate = MapDelegate(model: self)
        //ユーティリティにデリゲートを渡す
        MapUtil.setDelegate(delegate)
        //マップを2分割法で作成する
        MapUtil.repeatSplitRectangle()
        //Nodeを作る
        nodes = MapUtil.createNode()
        //キャラクターを配置する
        MapUtil.addAvatar(startNo, avatar:HeroManager.getHero())
        //描画する
        MapUtil.draw()
        //カメラを主人公の位置に移動させる
        MapUtil.onTouchCursor(-1)
    }
}