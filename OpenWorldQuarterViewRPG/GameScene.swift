//
//  GameScene.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var myWorld:SKNode = SKNode()
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var size:CGSize = view.frame.size
        
        self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        self.anchorPoint = CGPointMake(0.5, 1)
        myWorld.name = "world"
        
        
        var camera:SKNode = SKNode()
        camera.name = "camera"
        myWorld.addChild(camera)
        
        var OriginalRect:CGRect = CGRectMake(0, 0, 20, 20)
        
        var rect1:CGRect = CGRectMake(0, 0, 20, 20)
        var rect2:CGRect = CGRectMake(0, 0, 20, 20)
        var i:Int = 0;
        for (var width:Int = Int(rect1.size.width), height:Int = Int(rect1.size.height); width > 2 && height > 2 && i < 8; i++)
        {
            (rect1, rect2) = MapUtil.splitRect(rect1)
            MapUtil.createRectArea(myWorld, rect: rect1, type: i)
            width = Int(rect2.size.width)
            height = Int(rect2.size.height)
            rect1 = rect2
        }
        MapUtil.createRectArea(myWorld, rect: rect2, type: i)
        
        self.addChild(myWorld)
    }
    
    
    func centerOnNode(node:SKNode) {
        if let scene:SKScene = node.scene
        {
            var cameraPositionInScene:CGPoint = scene.convertPoint(node.position, fromNode: node.parent!)
            node.parent!.position = CGPointMake(node.parent!.position.x - cameraPositionInScene.x, node.parent!.position.y - cameraPositionInScene.y)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
