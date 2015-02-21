//
//  Node.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/21.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal struct Node
{
    internal var edges_to:[Int]
    internal var edges_cost:[Int]
    internal var done:Bool
    internal var cost:Int
    
    init (let edges_to:[Int], let edges_cost:[Int])
    {
        self.edges_to = edges_to
        self.edges_cost = edges_cost
        self.done = false
        self.cost = -1
    }
}