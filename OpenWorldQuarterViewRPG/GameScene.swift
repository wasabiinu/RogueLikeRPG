//
//  GameScene.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var mapModel:MapModel!;
    private var uiModel:UIModel!;
    private var myWorld:SKNode = SKNode()
    private var myUI:SKNode = SKNode()
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        var size:CGSize = view.frame.size
        
        self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        self.anchorPoint = CGPointMake(0.5, 1)
        myWorld.name = "world"
        myWorld.xScale = 1
        myWorld.yScale = 1
        
        myUI.name = "ui"
        myUI.xScale = 1
        myUI.yScale = 1
        
        var camera:SKNode = SKNode()
        camera.name = "camera"
        myWorld.addChild(camera)
        
        mapModel = MapModel(node: myWorld, scene:self)
        uiModel = UIModel(node: myWorld, ui:myUI, scene:self)
        
        self.addChild(myWorld)
        self.addChild(myUI)
    }
    
    deinit {
        mapModel = nil
        uiModel = nil
        myWorld = SKNode()
    }
    
    
    private func centerOnNode(node:SKNode) {
        if let scene:SKScene = node.scene
        {
            var cameraPositionInScene:CGPoint = scene.convertPoint(node.position, fromNode: node.parent!)
            node.parent!.position = CGPointMake(node.parent!.position.x - cameraPositionInScene.x, node.parent!.position.y - cameraPositionInScene.y)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        uiModel.touchesBegan(touches)
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        uiModel.touchesMoved(touches)
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
       
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
