//
//  GameScene.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class GroundGreen: MapChip {
    init(let num:Int) {
        let imageName:String = "ground.green." + String(num) + ".png";
        super.init(imageName: imageName)
    }
}

class MapChip {
    var node:SKSpriteNode;
    let startX:Int = 0;
    let startY:Int = -300;
    init(let imageName:String) {
        //var originalSet:SKTexture = SKTexture()
        var texture:SKTexture = SKTexture(imageNamed: imageName)
        node = SKSpriteNode(texture: texture)
        //node = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(1280, 800))
    }
    
    func position(let gridX:Int, let gridY:Int, let z:Int) {
        node.position = CGPointMake(CGFloat(gridX * -16 + gridY * 16 - startX), CGFloat(gridX * -12 + gridY * -12 - z - startY))
    }
}

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
        
        
        for (var y = 0; y < 10; y++)
        {
            for (var x = 0; x < 10; x++)
            {
                var groundChip:MapChip = GroundGreen(num:y)
                groundChip.position(x, gridY: y, z: 0)
                myWorld.addChild(groundChip.node)
            }
        }
        
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
