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
    init(let imageName:String) {
        var texture:SKTexture = SKTexture(imageNamed: imageName)
        spriteNode = SKSpriteNode(texture: texture)
    }
    
    func position(no:Int) {
        var gridY:Int = no / Int(MapConfig.AREA_SIZE.width)
        var gridX:Int = no % Int(MapConfig.AREA_SIZE.width)
        var z:Int = 0
        spriteNode.position = CGPointMake(CGFloat(gridX * -16 + gridY * 16), CGFloat((gridX * -12) + (gridY * -12) - z))
    }
}