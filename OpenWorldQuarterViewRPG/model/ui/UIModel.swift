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
    var ui:SKNode
    var scene:SKScene
    
    init (node:SKNode, ui:SKNode, scene:SKScene)
    {
        println("UIModel::init")
        self.node = node
        self.scene = scene
        self.ui = ui
        afterInit()
    }
    
    deinit {
        delegate = nil
    }
    
    private func afterInit()
    {
        //デリゲートを作る
        delegate = UIDelegate(model: self, scene:scene)
        //ユーティリティにデリゲートを渡す
        UIUtil.setDelegate(delegate)
        
        //コントローラーを作る
        var upButton:Cursor = Cursor()
        upButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 1
        upButton.spriteNode.name = "up"
        upButton.spriteNode.zRotation = CGFloat(45.0 * M_PI / 180.0)
        upButton.spriteNode.position = CGPoint(x: -250, y: -300)
        
        var leftButton:Cursor = Cursor()
        leftButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 2
        leftButton.spriteNode.name = "left"
        leftButton.spriteNode.zRotation = CGFloat(135.0 * M_PI / 180.0)
        leftButton.spriteNode.position = CGPoint(x: -250, y: -350)
        
        var downButton:Cursor = Cursor()
        downButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 3
        downButton.spriteNode.name = "down"
        downButton.spriteNode.zRotation = CGFloat(225.0 * M_PI / 180.0)
        downButton.spriteNode.position = CGPoint(x: -200, y: -350)
        
        var rightButton:Cursor = Cursor()
        rightButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 3
        rightButton.spriteNode.name = "right"
        rightButton.spriteNode.zRotation = CGFloat(315.0 * M_PI / 180.0)
        rightButton.spriteNode.position = CGPoint(x: -200, y: -300)
        
       
        
        ui.addChild(upButton.spriteNode)
        ui.addChild(leftButton.spriteNode)
        ui.addChild(rightButton.spriteNode)
        ui.addChild(downButton.spriteNode)
    }
    
    internal func touchesBegan(touches: NSSet) {
        
        UIUtil.setStartPos(touches)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(scene)
            
            var node:SKNode! = scene.nodeAtPoint(location);
            if(node != nil){
                if (node.name == "up")
                {
                    MapUtil.onTouchCursor(3)
                }
                else if(node.name == "left")
                {
                    MapUtil.onTouchCursor(0)
                }
                else if(node.name == "down")
                {
                    MapUtil.onTouchCursor(1)
                }
                else if(node.name == "right")
                {
                    MapUtil.onTouchCursor(2)
                }
                
            }
        }
    }
    
    internal func touchesMoved(touches: NSSet) {
        var touch:UITouch = touches.anyObject() as UITouch
        var touchPos:CGPoint = touch.locationInNode(scene)
        
        UIUtil.pinchInOut(touches)
        
        UIUtil.drag(touches, touchPos:touchPos)
    }
}