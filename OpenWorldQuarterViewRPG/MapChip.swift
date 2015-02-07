//
//  MapChip.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/07.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

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