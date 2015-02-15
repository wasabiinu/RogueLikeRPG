//
//  ChipInfo.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/08.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

struct ChipInfo {
    internal var type:Int
    internal var movable:Bool
    init (let type:Int, let movable:Bool)
    {
        self.type = type
        self.movable = movable
    }
}
