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
    var lock:Bool
    var scene:SKScene
    
    init (node:SKNode, ui:SKNode, scene:SKScene)
    {
        println("UIModel::init")
        self.node = node
        self.scene = scene
        self.ui = ui
        self.lock = false
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
        var leftupButton:Cursor = Cursor()
        leftupButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 1
        leftupButton.spriteNode.name = "leftup"
        leftupButton.spriteNode.zRotation = CGFloat(45.0 * M_PI / 180.0)
        leftupButton.spriteNode.position = CGPoint(x: -250, y: -300)
        
        var leftButton:Cursor = Cursor()
        leftButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 1
        leftButton.spriteNode.name = "left"
        leftButton.spriteNode.zRotation = CGFloat(90 * M_PI / 180.0)
        leftButton.spriteNode.position = CGPoint(x: -275, y: -325)
        
        var leftdownButton:Cursor = Cursor()
        leftdownButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 2
        leftdownButton.spriteNode.name = "leftdown"
        leftdownButton.spriteNode.zRotation = CGFloat(135.0 * M_PI / 180.0)
        leftdownButton.spriteNode.position = CGPoint(x: -250, y: -350)
        
        var downButton:Cursor = Cursor()
        downButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 2
        downButton.spriteNode.name = "down"
        downButton.spriteNode.zRotation = CGFloat(180.0 * M_PI / 180.0)
        downButton.spriteNode.position = CGPoint(x: -225, y: -375)
        
        var rightdownButton:Cursor = Cursor()
        rightdownButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 3
        rightdownButton.spriteNode.name = "rightdown"
        rightdownButton.spriteNode.zRotation = CGFloat(225.0 * M_PI / 180.0)
        rightdownButton.spriteNode.position = CGPoint(x: -200, y: -350)
        
        var rightButton:Cursor = Cursor()
        rightButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 3
        rightButton.spriteNode.name = "right"
        rightButton.spriteNode.zRotation = CGFloat(270.0 * M_PI / 180.0)
        rightButton.spriteNode.position = CGPoint(x: -175, y: -325)
        
        var rightupButton:Cursor = Cursor()
        rightupButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 3
        rightupButton.spriteNode.name = "rightup"
        rightupButton.spriteNode.zRotation = CGFloat(315.0 * M_PI / 180.0)
        rightupButton.spriteNode.position = CGPoint(x: -200, y: -300)
        
        var upButton:Cursor = Cursor()
        upButton.spriteNode.zPosition = MapConfig.AREA_SIZE.width * MapConfig.AREA_SIZE.height * 3 + 3
        upButton.spriteNode.name = "up"
        upButton.spriteNode.position = CGPoint(x: -225, y: -275)
        
       
        ui.addChild(leftButton.spriteNode)
        ui.addChild(downButton.spriteNode)
        ui.addChild(rightButton.spriteNode)
        ui.addChild(upButton.spriteNode)
        
        ui.addChild(leftupButton.spriteNode)
        ui.addChild(leftdownButton.spriteNode)
        ui.addChild(rightupButton.spriteNode)
        ui.addChild(rightdownButton.spriteNode)
    }
    
    internal func touchesBegan(touches: NSSet) {
        
        UIUtil.setStartPos(touches)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(scene)
            
            var node:SKNode! = scene.nodeAtPoint(location);
            if(node != nil){
                
                if(delegate.getModelLock() == false)
                {
                    if(node.name == "leftdown")
                    {
                        MapUtil.onTouchCursor(0)
                        self.lock = true
                    }
                    else if(node.name == "down")
                    {
                        MapUtil.onTouchCursor(1)
                        self.lock = true
                    }
                    else if(node.name == "rightdown")
                    {
                        MapUtil.onTouchCursor(2)
                        self.lock = true
                    }
                    else if(node.name == "right")
                    {
                        MapUtil.onTouchCursor(3)
                        self.lock = true
                    }
                    else if(node.name == "rightup")
                    {
                        MapUtil.onTouchCursor(4)
                        self.lock = true
                    }
                    else if(node.name == "up")
                    {
                        MapUtil.onTouchCursor(5)
                        self.lock = true
                    }
                    else if (node.name == "leftup")
                    {
                        MapUtil.onTouchCursor(6)
                        self.lock = true
                    }
                    else if (node.name == "left")
                    {
                        MapUtil.onTouchCursor(7)
                        self.lock = true
                    }
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
    
    internal func moveHero(callback:Void, option:[AnyObject])
    {
        MapUtil.moveAvatar(option[0] as Avatar, direction: MapUtil.delegate.getModelHeroNextDirection())
    }
}