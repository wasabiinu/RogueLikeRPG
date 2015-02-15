//
//  PassageInfo.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/16.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

internal struct RoomInfo {
    internal var neighbors:[NeighborRoomInfo]
    init ()
    {
        neighbors = [NeighborRoomInfo]()
    }
}