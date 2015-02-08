//
//  GameScene.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var startPos:CGPoint!;
    var myWorld:SKNode = SKNode()
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        var size:CGSize = view.frame.size
        
        self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        self.anchorPoint = CGPointMake(0.5, 1)
        myWorld.name = "world"
        myWorld.xScale = 2
        myWorld.yScale = 2
        
        
        var camera:SKNode = SKNode()
        camera.name = "camera"
        myWorld.addChild(camera)
        
        MapModel(node: myWorld)
        
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
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            startPos = location;
            var node:SKNode! = self.nodeAtPoint(location);
            if(node != nil){
                if(node.name=="world"){
                    //startPos = location;
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch:UITouch = touches.anyObject() as UITouch
        var touchPos:CGPoint = touch.locationInNode(self)
        
        //マップビューのドラッグ移動
        myWorld.position.x -= startPos.x - touchPos.x
        myWorld.position.y -= startPos.y - touchPos.y
        startPos.x -= startPos.x - touchPos.x
        startPos.y -= startPos.y - touchPos.y
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
