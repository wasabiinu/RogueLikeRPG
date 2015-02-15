//
//  MapChip.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/07.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//マップチップ親クラスです
//マップチップクラスを作る時はこのクラスを継承します

import SpriteKit

class MapChip {
    internal var node:SKSpriteNode;
    private var startX:Int = 0;
    private var startY:Int = 0;
    init(let imageName:String) {
        var texture:SKTexture = SKTexture(imageNamed: imageName)
        node = SKSpriteNode(texture: texture)
    }
    
    deinit {
        startX = 0
        startY = 0
    }
    
    //チップノードの位置を代入します
    //グリッドの値を受け取り、ドット的な値にします
    func position(let gridX:Int, let gridY:Int, let z:Int) {
        node.position = CGPointMake(CGFloat(gridX * -16 + gridY * 16 - startX), CGFloat(gridX * -12 + gridY * -12 - z - startY))
    }
}