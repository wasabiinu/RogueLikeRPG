//
//  NeighborRoomInfo.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/16.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

internal struct NeighborRoomInfo {
    internal var rect:CGRect!
    internal var direction:Int = 0 //0:左下方向、1:右下方向、2:右上、3:左上
    init ()
    {
    }
}