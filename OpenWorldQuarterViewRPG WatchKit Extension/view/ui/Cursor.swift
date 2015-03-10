//
//  Cursor.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/22.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import SpriteKit
internal class Cursor
{
    internal var spriteNode:SKSpriteNode
    init ()
    {
        var texture:SKTexture = SKTexture(imageNamed: "ui.cursor.png")
        spriteNode = SKSpriteNode(texture: texture)
    }
}