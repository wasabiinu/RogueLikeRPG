//
//  GroundGreen.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/07.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class GroundGreen: MapChip {
    init(let num:Int) {
        let imageName:String = "ground.green." + String(num) + ".png";
        super.init(imageName: imageName)
    }
}