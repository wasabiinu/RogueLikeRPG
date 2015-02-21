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
        nodes.append(Node(edges_to: [1,2], edges_cost: [1,3]))
        nodes.append(Node(edges_to:[2,3], edges_cost:[1,4]))
        nodes.append(Node(edges_to: [3], edges_cost: [1]))
        nodes.append(Node(edges_to: [4,5],edges_cost: [1,10]))
        nodes.append(Node(edges_to: [5],edges_cost: [1]))
        nodes.append(Node(edges_to: [-1], edges_cost: [1]))
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



/*
internal class DijkstraTest
{
    init (){
        // set up a graph
        var s:Vertex  = Vertex(value: 0)
        var v1:Vertex = Vertex(value: 1)
        var v2:Vertex = Vertex(value: 2)
        var v3:Vertex = Vertex(value: 3)
        var v4:Vertex = Vertex(value: 4)
        var g:Vertex  = Vertex(value: 5)
        // set up connections
        // 単純化のためループや往路を除去した
        s.appendNeighbor([1, 3], argumentsVertex: [v1, v2])
        v1.appendNeighbor([1, 4], argumentsVertex: [v2, v3])
        v2.appendNeighbor([1], argumentsVertex: [v3])
        v3.appendNeighbor([1, 10], argumentsVertex: [v4, g])
        v4.appendNeighbor([1], argumentsVertex: [g])
        
        // initialize
        var vertexes:[Vertex] = [s, v1, v2, v3, v4, g];
        var pred:[Int] = [Int]()
        var pq:BinaryHeap = BinaryHeap()// sからの距離が短い頂点順の優先度つきキュー
        s.dist = 0;
        for(var i = 0; i < vertexes.count; i++){// キューの生成
            pred.append(-1);
            pq.insert(vertexes[i], priority:Int(vertexes[i].dist));
        }
        
        dijkstraPQ(pq, pred)
        print("最短距離:\(g.dist)")
    }
}

internal func dijkstraPQ(pq:BinaryHeap, pred:[Int])
{
    println("dijkstraPQ")
    var _pred:[Int] = pred
    while(pq._ary.count > 0){
        var u:Vertex = pq.getPrior() // スタートからの距離が近い頂点を取得しcurrent頂点とする
        for(var i = 0; i < u.neighbor.count; i++){
            var neighbor:Vertex  = u.neighbor[i].vertex
            var weight:Int    = u.neighbor[i].weight // 隣接点の距離...(a)
            var newLength = u.dist + weight // current頂点のsからの距離と(a)を加算...(b)
            // (b) < visitした時の距離の場合
            // キューを更新し、最短経路も更新する
            if(newLength < neighbor.dist){
                pq.changePriority(neighbor, priority: newLength)
                neighbor.dist = newLength
                _pred[neighbor.value] = Int(u.value)
            }
        }
    }
    
    println("最短経路:\(_pred)")
}

internal class Vertex{
    
    internal var value:Int
    internal var stat:Int = 0
    internal var dist:Int = 999999
    internal var neighbor:[Neighbor] = [Neighbor]()
    
    internal struct Neighbor
    {
        internal var weight:Int
        internal var vertex:Vertex
        init(weight:Int, vertex:Vertex)
        {
            self.weight = weight
            self.vertex = vertex
        }
    }
    
    init(value:Int)
    {
        self.value = value
    }
    
    internal func appendNeighbor(argumentsWeight:[Int], argumentsVertex:[Vertex])
    {
        var i:Int = 0
        for (i = 0; i < argumentsWeight.count; i++)
        {
            self.neighbor.append(Neighbor(weight:argumentsWeight[i], vertex:argumentsVertex[i]))
        }
    }
}

/**
* BinaryHeap
*/
internal class BinaryHeap
{
    
    internal var _ary:[Element] = [Element]()
    
    internal struct Element
    {
        init(vertex:Vertex, priority:Int)
        {
            self.vertex = vertex
            self.priority = priority
        }
        internal var vertex:Vertex
        internal var priority:Int
    }
    
    init()
    {
        
    }
    
    private func build()
    {
        var ary:[Element] = self._ary;
        for(var i:Int = ary.count - 1; i >= 0; i--){
            heapify(ary, i: i, max: self._ary.count)
        }
    }
    
    /**
    * BinaryHeap::insert
    * @param {Object} elm
    * @param {int} priority
    */
    internal func insert(vertex:Vertex, priority:Int)
    {
        self._ary.append(Element(vertex: vertex, priority: priority))
        self.build()
    }
    
    /**
    * BinaryHeap::changePriority
    * @param {Object} elm
    * @param {int} priority
    */
    internal func changePriority(vertex:Vertex, priority:Int) -> Bool
    {
        var ary:[Element]  = self._ary
        var _vertex = vertex
        for(var i:Int = 0; i < ary.count; i++)
        {
            var aryVertex:Vertex = ary[i].vertex
            if(_vertex === aryVertex)
            {
                ary[i].priority = priority
                self.build()
                return true
            }
        }
        return false
    }
    
    /**
    * swap
    * @param {array} ary
    * @param {int} x
    * @param {int} y
    */
    private func swap(var ary:[Element], x:Int, y:Int)
    {
        var a:Element = ary[x]
        var b:Element = ary[y]
        ary[x] = b
        ary[y] = a
    }
    
    /**
    * heapify
    * 3要素を比較し最も小さい要素を親とする
    * @param {array} ary
    * @param {int} i
    * @param {max} max
    */
    private func heapify(var ary:[Element], i:Int, max:Int)
    {
        var l = 2 * i + 1
        var r = 2 * i + 2
        var li:Int = 0;
        if(l < max && ary[l].priority < ary[i].priority){
            li = l
        }
        else{
            li = i
        }
        if(r < max && ary[r].priority < ary[li].priority){
            li = r
        }
        if(li != i){
            swap(ary, x: i, y: li)
            heapify(ary, i: li, max: max)
        }
    }
    
    /**
    * BinaryHeap::getPrior
    */
    internal func getPrior() -> Vertex
    {
        var elm:Element  = self._ary.removeLast()
        self.build()
        return elm.vertex
    }
}*/