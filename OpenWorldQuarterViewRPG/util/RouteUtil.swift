//
//  RouteUtil.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/21.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class RouteUtil
{
    internal class func getRoute(var nodes:[Node], start:Int, goal:Int) -> [Int]
    {
        
        return doDijkstra(nodes, start:start, goal:goal)
    }
    
    internal class func getArrival(var nodes:[Node], start:Int, goal:Int) -> Bool
    {
        if(doDijkstra(nodes, start:start, goal:goal).count > 0)
        {
            return true
        }
        return false
    }
    
    private class func doDijkstra(var nodes:[Node], start:Int, goal:Int) -> [Int]
    {
        //スタートのコストは0
        nodes[start].cost = 0
        //道筋
        var routes:[Int] = [Int]()
        var reached:Bool = false
        
        //アルゴリズム実行
        loop: for(var loop:Int = 0; loop < 10000 ; loop++)
        {
            //確定ノードを探す
            var doneNode:Node? = nil //確定ノード
            var doneNodeNumber:Int = -1
            search: for(var searchLoop:Int = 0; searchLoop < nodes.count; searchLoop++)
            {
                var node:Node = nodes[searchLoop]
                //一度もcostに代入されていないnodeか、すでに調査済みのノードの場合次のノードに進む
                if (node.done == true || node.cost < 0)
                {
                    continue search
                }
                
                //確定ノードが今まで1つも無い場合か、nodeのcostが今の確定ノードよりも小さければ確定ノードに代入
                if (doneNode == nil || node.cost < doneNode?.cost)
                {
                    doneNode = node
                    doneNodeNumber = searchLoop
                }
                
                //確定ノードがなくなれば終了
                if (doneNode == nil)
                {
                    break search
                }
            }
            
            //確定フラグを立てる
            if (doneNodeNumber >= 0)
            {
                nodes[doneNodeNumber].done = true
                routes.append(doneNodeNumber)
            }
            
            //ゴールに到達していたらループを抜ける
            if (doneNodeNumber == goal)
            {
                reached = true
                break loop
            }
            
            //接続先ノードの情報を更新する
            for (var i:Int = 0; i < doneNode?.edges_to.count; i++)
            {
                var to:Int = doneNode!.edges_to[i]
                var cost:Int = doneNode!.cost + doneNode!.edges_cost[i]
                if (nodes[to].cost < 0 || cost < nodes[to].cost)
                {
                    nodes[to].cost = cost
                }
            }
            
        }
        if (reached == false)
        {
            return []
        }
        return routes
    }
}