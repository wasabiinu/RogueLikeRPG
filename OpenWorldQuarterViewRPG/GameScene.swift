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

class RectCheck: MapChip {
    init(let num:Int) {
        let imageName:String = "ground.rectcheck." + String(num) + ".png";
        super.init(imageName: imageName)
    }
}

class MapChip {
    var node:SKSpriteNode;
    let startX:Int = 0;
    let startY:Int = 0;
    init(let imageName:String) {
        var texture:SKTexture = SKTexture(imageNamed: imageName)
        node = SKSpriteNode(texture: texture)
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
        
        
        /*
        for (var y = 0; y < 20; y++)
        {
            for (var x = 0; x < 20; x++)
            {
                var groundChip:MapChip = GroundGreen(num:0)
                groundChip.position(x, gridY: y, z: 0)
                myWorld.addChild(groundChip.node)
            }
        }
        */
        
        
        let(rect1, rect2) = splitRect(CGRectMake(0, 0, 20, 20))
        
        createRectArea(myWorld, rect: rect1, type: 2)
        createRectArea(myWorld, rect: rect2, type: 3)
        
        self.addChild(myWorld)
    }
    
    func createRectArea(let world:SKNode, let rect:CGRect, let type:Int)
    {
        var dx:Int = Int(rect.origin.x)
        var dy:Int = Int(rect.origin.y)
        var width:Int = Int(rect.size.width)
        var height:Int = Int(rect.size.height)
        for (var y = dy; y < dy + height; y++)
        {
            for (var x = dx; x < dx + width; x++)
            {
                var groundChip:MapChip = RectCheck(num:type)
                groundChip.position(x, gridY: y, z: 0)
                world.addChild(groundChip.node)
            }
        }
    }
    
    /**
    * レクタングルを縦横どちらかランダムに2分割して返す
    */
    func splitRect(let OriginalRect:CGRect) -> (CGRect, CGRect)
    {
        var direction:Int = Int(arc4random_uniform(2))
        var rect1:CGRect
        var rect2:CGRect
        
        
        //横分割
        if (direction == 1)
        {
            var seedWidth:UInt32 = UInt32(OriginalRect.size.width) - 1
            var splitWidth:CGFloat = CGFloat(arc4random_uniform(seedWidth))
            rect1 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y, splitWidth, OriginalRect.size.height)
            rect2 = CGRectMake(OriginalRect.origin.x + splitWidth, OriginalRect.origin.y, OriginalRect.size.width - rect1.size.width, OriginalRect.size.height)
        }
        //縦分割
        else
        {
            var seedHeight:UInt32 = UInt32(OriginalRect.size.height) - 1
            var splitHeight:CGFloat = CGFloat(arc4random_uniform(seedHeight))
            rect1 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y, OriginalRect.size.width, splitHeight)
            rect2 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y + splitHeight, OriginalRect.size.width, OriginalRect.size.height - rect1.size.height)
        }
    
        return (rect1, rect2)
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
