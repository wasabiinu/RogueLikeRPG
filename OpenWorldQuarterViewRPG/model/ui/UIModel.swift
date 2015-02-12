//
//  UIModel.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/12.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class UIModel {
    var delegate:UIDelegate!;
    var node:SKNode;
    var scene:SKScene
    
    init (node:SKNode, scene:SKScene)
    {
        println("UIModel::init")
        self.node = node
        self.scene = scene
        afterInit()
    }
    
    func afterInit()
    {
        //デリゲートを作る
        delegate = UIDelegate(model: self, scene:scene)
        //ユーティリティにデリゲートを渡す
        UIUtil.setDelegate(delegate)
    }
    
    func touchesBegan(touches: NSSet) {
        
        UIUtil.setStartPos(touches)
    }
    
    func touchesMoved(touches: NSSet) {
        var touch:UITouch = touches.anyObject() as UITouch
        var touchPos:CGPoint = touch.locationInNode(scene)
        
        UIUtil.pinchInOut(touches)
        
        UIUtil.drag(touches, touchPos:touchPos)
    }
}