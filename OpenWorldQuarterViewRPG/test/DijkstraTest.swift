//
//  DijkstraTest.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/21.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//参考　http://www.deqnotes.net/acmicpc/dijkstra/

import Foundation




internal class DijkstraTest
{
    internal var nodes:[Node]
    internal let startNo:Int = 0
    internal let goalNo:Int = 5
    
    init (){
        nodes = [Node]()
        /*
        nodes.append(Node(edges_to: [1,2], edges_cost: [1,3]))
        nodes.append(Node(edges_to:[2,3], edges_cost:[1,4]))
        nodes.append(Node(edges_to: [3], edges_cost: [1]))
        nodes.append(Node(edges_to: [4,5],edges_cost: [1,10]))
        nodes.append(Node(edges_to: [5],edges_cost: [1]))
        nodes.append(Node(edges_to: [-1], edges_cost: [1]))
        */
        self.doDijkstra()
    }
    
    internal func doDijkstra()
    {
        //スタートのコストは0
        nodes[startNo].cost = 0
        //道筋
        var routes:[Int] = [Int]()
        
        //アルゴリズム実行
        loop: for(var loop:Int = 0; loop < 100 ; loop++)
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
        
            println("edges_to:\(doneNode?.edges_to), doneNode.cost:\(doneNode?.cost)")
            
            //確定フラグを立てる
            nodes[doneNodeNumber].done = true
            routes.append(doneNodeNumber)
            
            //ゴールに到達していたらループを抜ける
            if (doneNodeNumber == goalNo)
            {
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
                    println("to:\(to), cost:\(cost)")
                }
            }
            
        }
        
        println(routes)
    }

}