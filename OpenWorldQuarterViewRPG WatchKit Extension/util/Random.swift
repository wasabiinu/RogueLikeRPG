//
//  Random.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/16.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

internal class Random
{
    init ()
    {
        
    }
    
    internal class func random(max:UInt32) -> UInt32
    {
        return arc4random_uniform(max)
    }
}