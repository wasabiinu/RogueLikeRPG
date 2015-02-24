//
//  Avatar.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/22.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//Avatarの基本クラスです
//Avatarを作る場合は、このクラスを継承して下さい

import Foundation
import SpriteKit
internal class Avatar
{
    internal var spriteNode:SKSpriteNode
    internal var nodeNo:Int
    internal var walk0Textures:[SKTexture]
    internal var walk1Textures:[SKTexture]
    internal var walk3Textures:[SKTexture]
    internal var walk4Textures:[SKTexture]
    internal var walk5Textures:[SKTexture]
    init(let imageName:String) {
        var texture:SKTexture = SKTexture(imageNamed: imageName)
        spriteNode = SKSpriteNode(texture: texture)
        spriteNode.xScale = 0.5
        spriteNode.yScale = 0.5
        walk0Textures = [SKTexture]()
        walk1Textures = [SKTexture]()
        walk3Textures = [SKTexture]()
        walk4Textures = [SKTexture]()
        walk5Textures = [SKTexture]()
        self.nodeNo = 0
    }
    
    func position(no:Int, direction:Int = 0, immidiate:Bool = false) {
        
        var walk:SKAction
        if (direction == 0 || direction == 2)
        {
            walk = SKAction.animateWithTextures(walk0Textures, timePerFrame: 0.2)
        }
        else if(direction == 1)
        {
            walk = SKAction.animateWithTextures(walk1Textures, timePerFrame: 0.2)
        }
        else if(direction == 3 || direction == 7)
        {
            walk = SKAction.animateWithTextures(walk3Textures, timePerFrame: 0.2)
        }
        else if(direction == 4 || direction == 6)
        {
            walk = SKAction.animateWithTextures(walk4Textures, timePerFrame: 0.2)
        }
        else
        {
            walk = SKAction.animateWithTextures(walk5Textures, timePerFrame: 0.2)
        }
        
        if (direction == 2 || direction == 6 || direction == 3)
        {
            if (self.spriteNode.xScale > 0)
            {
                self.spriteNode.xScale *= -1
            }
        }
        else
        {
            if (self.spriteNode.xScale < 0)
            {
                self.spriteNode.xScale *= -1
            }
        }
        
        var gridY:Int = no / Int(MapConfig.AREA_SIZE.width)
        var gridX:Int = no % Int(MapConfig.AREA_SIZE.width)
        var z:Int = -19
        nodeNo = no
        
        
        var oldX:CGFloat = spriteNode.position.x
        var oldY:CGFloat = spriteNode.position.y
        
        var newX:CGFloat = CGFloat(gridX * -16 + gridY * 16)
        var newY:CGFloat = CGFloat((gridX * -12) + (gridY * -12) - z)
        
        var diffX:CGFloat = newX - oldX
        var diffY:CGFloat = newY - oldY
        
        if(immidiate == true)
        {
            self.spriteNode.position = CGPointMake(newX, newY)
            self.spriteNode.zPosition = CGFloat(no * 2 + 1)
        }
        else
        {
            AloeTween.doTween(0.4, ease: AloeEase.None, progress: { (val) -> () in
                self.spriteNode.position = CGPointMake(oldX + diffX * val, oldY + diffY * val)
                if (direction >= 4)
                {
                    if( val >= 1)
                    {
                        self.spriteNode.zPosition = CGFloat(no * 2 + 1)
                    }
                }
                else
                {
                    if( val >= 0.1)
                    {
                        self.spriteNode.zPosition = CGFloat(no * 2 + 1)
                    }
                }
                
                //タイマーマネージャーを作るまでの暫定対応
                if( val >= 1)
                {
                    UIUtil.delegate.sestModelLock(false)
                }
                
            })
            spriteNode.runAction(walk)
        }
    }
}