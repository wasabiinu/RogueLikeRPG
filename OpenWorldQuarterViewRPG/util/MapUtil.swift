//
//  MapUtil.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/07.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//Mapで使う機能を実装します

import SpriteKit

internal class MapUtil {
    
    internal class var delegate:MapDelegate
    {
        set {
            ClassProperty.delegate = newValue
        }
        get {
            return ClassProperty.delegate
        }
    }

    private struct ClassProperty {
        static var delegate:MapDelegate!
    }

    internal class func setDelegate(delegate:MapDelegate)
    {
        println("MapUtil::setDelegate")
        self.delegate = delegate
    }
    
    //受け取ったサイズのレクタングルとタイプでエリアを作って、受け取った親に加えます
    internal class func createRectArea(let rect:CGRect, let type:Int)
    {
        var dx:Int = Int(rect.origin.x)
        var dy:Int = Int(rect.origin.y)
        var width:Int = Int(rect.size.width)
        var height:Int = Int(rect.size.height)
        for (var y = dy; y < dy + height; y++)
        {
            for (var x = dx; x < dx + width; x++)
            {
                var groundChip:MapChip = RectTestChip(num:type)
                groundChip.position(x, gridY: y, z: 0)
                self.delegate.getModelNode().addChild(groundChip.node)
            }
        }
    }
    
    internal class func addChip(gridX:Int, gridY:Int, var z:Int, info:ChipInfo, zPosition:CGFloat)
    {
        var groundChip:MapChip = RectTestChip(num:info.type)
        if (info.movable == false)
        {
            z -= 14;
        }
        groundChip.position(gridX, gridY: gridY, z: z)
        groundChip.node.zPosition = zPosition
        self.delegate.getModelNode().addChild(groundChip.node)
    }
    
    //レクタングルを縦横どちらかランダムに2分割して返します
    private class func twoSplitRect(let OriginalRect:CGRect) -> (CGRect, CGRect)
    {
        var direction:Int = Int(Random.random(2))
        var rect1:CGRect
        var rect2:CGRect
        
        
        //横分割
        if (direction == 1)
        {
            //横幅の1/2
            var seedWidth:UInt32 = UInt32(OriginalRect.size.width  / 2)
            //横幅の1/4〜3/4にする
            //横幅の0〜1/2を作り、1/4を加える
            var splitWidth:CGFloat = CGFloat(Random.random(seedWidth) + seedWidth / 2)
            rect1 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y, splitWidth, OriginalRect.size.height)
            rect2 = CGRectMake(OriginalRect.origin.x + splitWidth, OriginalRect.origin.y, OriginalRect.size.width - rect1.size.width, OriginalRect.size.height)
        }
        //縦分割
        else
        {
            //縦幅の1/2
            var seedHeight:UInt32 = UInt32(OriginalRect.size.height / 2)
            //縦幅の1/4〜3/4にする
            //縦幅の0〜1/2を作り、1/4を加える
            var splitHeight:CGFloat = CGFloat(Random.random(seedHeight) + seedHeight / 2)
            rect1 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y, OriginalRect.size.width, splitHeight)
            rect2 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y + splitHeight, OriginalRect.size.width, OriginalRect.size.height - rect1.size.height)
        }
        
        return (rect1, rect2)
    }
    
    //分割を繰り返す
    internal class func repeatSplitRectangle()
    {
        var OriginalRect:CGRect = CGRectMake(0, 0, MapConfig.AREA_SIZE.width, MapConfig.AREA_SIZE.height)
        var rect1:CGRect = CGRectMake(0, 0, MapConfig.AREA_SIZE.width, MapConfig.AREA_SIZE.height)
        var rect2:CGRect = CGRectMake(0, 0, MapConfig.AREA_SIZE.width, MapConfig.AREA_SIZE.height)
        var rectArray:[CGRect] = [CGRect]()
        var i:Int = 0;
        var minWidth:Int = 2;
        var minHeight:Int = 2;
        for (var width:Int = Int(rect1.size.width), height:Int = Int(rect1.size.height); width > minWidth && height > minHeight && i < 8; i++)
        {
            (rect1, rect2) = MapUtil.twoSplitRect(rect1)
            
            
            //rect1をDictionaryに登録する
            //一旦、壁を格納する　type = 1
            registChipInfo(rect1, type: 3, moovable: false)
            
            rectArray.append(rect1)
            
            width = Int(rect2.size.width)
            height = Int(rect2.size.height)
            
            
            rect1 = rect2
        }
        //はみ出したぶんを登録
        registChipInfo(rect1, type: 3, moovable: false)
        rectArray.append(rect1)
        
        //部屋を作る
        var roomArray:[CGRect] = createRooms(rectArray)
        
        //通路を作る
        createPasseges(roomArray)
        
        //ランダムに回転させる
        let xRotationNum:UInt32 = Random.random(2)
        let yRotationNum:UInt32 = Random.random(2)
        //rotateRectangleArea(xRotationNum == 1, yRotation: yRotationNum == 1)
    }
    
    //部屋を作って登録する
    private class func createRooms(let array:[CGRect]) -> [CGRect]
    {
        var roomArray:[CGRect] = [CGRect]()
        for rect:CGRect in array
        {
            //格納されるエリアの1/4〜3/4の大きさのレクタングルを作る
            var roomX:CGFloat, roomY:CGFloat, roomWidth:CGFloat ,roomHeight:CGFloat
            
            roomX = CGFloat(Random.random(UInt32(rect.width / 4))) + 1
            roomY = CGFloat(Random.random(UInt32(rect.height / 4))) + 1
            roomWidth = rect.width - CGFloat(Random.random(UInt32(rect.width) / 4)) - roomX - 1
            roomHeight = rect.height - CGFloat(Random.random(UInt32(rect.height) / 4)) - roomY - 1
            roomX += rect.origin.x
            roomY += rect.origin.y
            if (roomWidth > 0 && roomHeight > 0)
            {
                roomArray.append(CGRectMake(roomX, roomY, roomWidth, roomHeight))
            }
        }
        
        //作ったレクタングルを登録する
        for rect2:CGRect in roomArray
        {
            registChipInfo(rect2, type: 0, moovable: true)
        }
        
        return roomArray
    }
    
    //通路を作って登録する
    private class func createPasseges(roomArray:[CGRect])
    {
        //各部屋の接続情報を格納する配列
        var nodes:[Node] = [Node]()
        
        //格納させているレクタングルを順番に比較する
        for (var originIndex:Int = 0; roomArray.count > originIndex; originIndex++)
        {
            println("originIndex:\(originIndex)")
            var originRect:CGRect = roomArray[originIndex]
            var passageRect:CGRect = CGRect()
            
            //接続先リスト
            var intersects:[Int] = [Int]()
            var costs:[Int] = [Int]()
            var passages:[Passage] = [Passage]()
            
            
            //originRectの外周グリッド起点で十分に長い幅１グリッドの通路レクタングルを1方向ずつ、１グリずらしでのばし、rect2と重なるか調べる
            //長さを１グリずつのばしていって、先にほかのレクトと交差しないかチェックする
           
            var originX:CGFloat
            var originY:CGFloat
            var xWidth:CGFloat
            var yWidth:CGFloat
            var registPassageRect:CGRect
            
            var dictionary:Dictionary<HashableRect, Passage> = Dictionary<HashableRect, Passage>()
            
            //左下＝direction0
            //幅移動　originYが変化していく
            for (originY = originRect.origin.y; originY < originRect.size.height + originRect.origin.y; originY++)
            {
                //長さ移動　xが変化していく
                changeIntersectX: for (xWidth = 0; xWidth < 100; xWidth++)
                {
                    //起点は、x:originRectのx＋幅で固定、y:originRectのy〜originRectのy+originY
                    //width:1ずつ増えていく、height:1で固定
                    passageRect = CGRectMake(originRect.origin.x + originRect.width, originY, xWidth, 1)
                    //passageと交差するレクタングルがあるか
                    for (var roomCount:Int = 0; roomCount < roomArray.count; roomCount++)
                    {
                        var intersectRect:CGRect = roomArray[roomCount]
                        if (CGRectIntersectsRect(passageRect, intersectRect))
                        {
                            //交差した情報を格納する
                            
                            var hashableRect:HashableRect = HashableRect(x: intersectRect.origin.x, y: intersectRect.origin.y, width: intersectRect.size.width, height: intersectRect.size.height)
                            
                            //初期化
                            if (dictionary[hashableRect] == nil)
                            {
                                dictionary[hashableRect] = Passage(originRect: originRect, roomNum:roomCount)
                            }
                            
                            if(xWidth - 1 > 0)
                            {
                                registPassageRect = CGRectMake(originRect.origin.x + originRect.width, originY, xWidth - 1, 1)
                                dictionary[hashableRect]!.setPassage(hashableRect, passageRect: registPassageRect)
                            }
                            
                            //交差したレクタングルを登録する
                            var isReg:Bool = false
                            for intersectNum:Int in intersects
                            {
                                if( intersectNum == roomCount)
                                {
                                    isReg = true
                                }
                            }
                            
                            if (isReg == false)
                            {
                                intersects.append(roomCount)
                                costs.append(1)
                            }
                            
                            //交差したレクタングルがあったから、通路を延ばすのをやめる
                            break changeIntersectX
                        }
                    }
                }
            }
            
            //右下=direction1
            //幅移動　originXが変化していく
            for (originX = originRect.origin.x; originX < originRect.size.width + originRect.origin.x; originX++)
            {
                //長さ移動　yが変化していく
                changeIntersectY: for (yWidth = 0; yWidth < 100; yWidth++)
                {
                    //起点は、y:originRectのy＋幅で固定、x:originRectのx〜originRectのx+originX
                    //height:1ずつ増えていく、width:1で固定
                    passageRect = CGRectMake(originX, originRect.origin.y + originRect.height, 1, yWidth)
                    //passageと交差するレクタングルがあるか
                    for (var roomCount:Int = 0; roomCount < roomArray.count; roomCount++)
                    {
                        var intersectRect:CGRect = roomArray[roomCount]
                        if (CGRectIntersectsRect(passageRect, intersectRect))
                        {
                            //交差した情報を格納する
                            
                            var hashableRect:HashableRect = HashableRect(x: intersectRect.origin.x, y: intersectRect.origin.y, width: intersectRect.size.width, height: intersectRect.size.height)
                            
                            //初期化
                            if (dictionary[hashableRect] == nil)
                            {
                                dictionary[hashableRect] = Passage(originRect: originRect, roomNum:roomCount)
                            }
                            
                            if (yWidth - 1 > 0)
                            {
                                registPassageRect = CGRectMake(originX, originRect.origin.y + originRect.height, 1, yWidth - 1)
                                dictionary[hashableRect]!.setPassage(hashableRect, passageRect: registPassageRect)
                            }
                            
                            //交差したレクタングルを登録する
                            var isReg:Bool = false
                            for intersectNum:Int in intersects
                            {
                                if( intersectNum == roomCount)
                                {
                                    isReg = true
                                }
                            }
                            
                            if (isReg == false)
                            {
                                intersects.append(roomCount)
                                costs.append(1)
                            }
                            
                            //交差したレクタングルがあったから、通路を延ばすのをやめる
                            
                            break changeIntersectY
                        }
                    }
                }
            }
            
            //生成方向的に考えて、右上、左上の調査は不要のはず
            
            
            //初期化
            for passage:Passage in dictionary.values {
                passages.append(passage)
            }
            
            for passage:Passage in dictionary.values {
                for(var j:Int = 0; j < intersects.count; j++)
                {
                    if (j == passage.roomNum)
                    {
                        passages[passage.roomNum] = passage
                    }
                }
            }
            
            //接続先情報を登録する
            nodes.append(Node(edges_to: intersects, edges_cost: costs, passages: passages))
        }
        
        //スタート通路を作る
        var start:Int = 0
        var startPassageRect:CGRect = CGRectMake(0, 0, 0, 0)
        startLoop: while(true)
        {
            var startPassageX:CGFloat = CGFloat(Random.random(UInt32(MapConfig.AREA_SIZE.width) - 2) + 1)
            for (var startPassageHeight:CGFloat = 1; startPassageHeight < MapConfig.AREA_SIZE.width; startPassageHeight++)
            {
                startPassageRect = CGRectMake(startPassageX, 0, 1, startPassageHeight)
                for (var startRoomNum:Int = 0; startRoomNum < roomArray.count; startRoomNum++)
                {
                    var intersectRoomRect:CGRect = roomArray[startRoomNum]
                    if (CGRectIntersectsRect(startPassageRect, intersectRoomRect))
                    {
                        start = startRoomNum
                        break startLoop
                    }
                }
            }
        }
        
        //ゴール通路を作る
        var goal:Int = nodes.count - 1
        var goalPassageRect:CGRect = CGRectMake(0, 0, 0, 0)
        goalLoop: while(true)
        {
            var goalPassageX:CGFloat = CGFloat(Random.random(UInt32(MapConfig.AREA_SIZE.width) - 2) + 1)
            for (var goalPassageHeight:CGFloat = 1; goalPassageHeight < MapConfig.AREA_SIZE.width; goalPassageHeight++)
            {
                goalPassageRect = CGRectMake(goalPassageX, MapConfig.AREA_SIZE.height - goalPassageHeight, 1, goalPassageHeight)
                for (var goalRoomNum:Int = 0; goalRoomNum < roomArray.count; goalRoomNum++)
                {
                    var intersectRoomRectGoal:CGRect = roomArray[goalRoomNum]
                    if (CGRectIntersectsRect(goalPassageRect, intersectRoomRectGoal))
                    {
                        goal = goalRoomNum
                        break goalLoop
                    }
                }
            }
        }
        
        
        for (var nodeNum:Int = 0; nodeNum < nodes.count; nodeNum++)
        {
            var node:Node = nodes[nodeNum]
            var edges_to:[Int] = node.edges_to
            for (var removeNum:Int = 0; removeNum < edges_to.count; removeNum++)
            {
                var _nodes:[Node] = nodes
                
                if (_nodes[nodeNum].edges_to.count <= removeNum)
                {
                    continue
                }
                _nodes[nodeNum].edges_to.removeAtIndex(removeNum)
                _nodes[nodeNum].edges_cost.removeAtIndex(removeNum)
                _nodes[nodeNum].passages.removeAtIndex(removeNum)
                
                if (RouteUtil.getArrival(_nodes, start: start, goal: nodeNum) || RouteUtil.getArrival(_nodes, start: nodeNum, goal: goal))
                {
                    nodes = _nodes
                }
                
            }
            
        }
        
        //nodesから通路を登録していく
        for node:Node in nodes
        {
            var passages:[Passage] = node.passages
            for passage:Passage in passages
            {
                var array:[CGRect] = passage.getRandomPassage()
                for cgRect:CGRect in array {
                    registChipInfo(cgRect, type: 4, moovable: true)
                }
            }
        }
        
        //スタート通路を登録
        startPassageRect = CGRectMake(startPassageRect.origin.x, startPassageRect.origin.y, startPassageRect.size.width, startPassageRect.size.height - 1)
        registChipInfo(startPassageRect, type: 4, moovable: true)
        
        //ゴール通路を登録
        goalPassageRect = CGRectMake(goalPassageRect.origin.x, goalPassageRect.origin.y + 1, goalPassageRect.size.width, goalPassageRect.size.height - 1)
        registChipInfo(goalPassageRect, type: 4, moovable: true)
        
    }
    
    //レクタングルをDictionaryに登録する
    private class func registChipInfo(let rect:CGRect, let type:Int, let moovable:Bool)
    {
        for (var registWidth:CGFloat = 0; registWidth < rect.size.width; registWidth++)
        {
            for (var registHeight:CGFloat = 0; registHeight < rect.size.height; registHeight++)
            {
                self.delegate.setModelChipDictionary("\(Int(registWidth + rect.origin.x)),\(Int(registHeight + rect.origin.y))", info: ChipInfo(type: type, movable: moovable))
            }
        }
    }
    
    //作成したマップエリアを回転させる
    private class func rotateRectangleArea(xRotation:Bool, yRotation:Bool)
    {
        println("MapUtil::rotateRectangleArea")
        if (xRotation == false && yRotation == false)
        {
            return
        }
        
        var x:Int = 0, y:Int = 0, xCount:Int = 0, yCount:Int = 0
        let dictionary:Dictionary<String, ChipInfo> = self.delegate.getModelChipDictionary()
        for (x = 0; dictionary["\(x),\(y)"] != nil; x++)
        {
            for (y = 0; dictionary["\(x),\(y)"] != nil; y++)
            {
                
            }
            yCount = y
            y = 0
        }
        xCount = x
        
        x = 0
        y = 0
        for (x = 0; x < xCount; x++)
        {
            for (y = 0; y < yCount; y++)
            {
                //両回転
                if (xRotation == true && yRotation == true)
                {
                    self.delegate.setModelChipDictionary("\(xCount - x - 1),\(yCount - y - 1)", info: dictionary["\(x),\(y)"]!)
                }
                //xだけ回転
                else if(xRotation == true && yRotation == false)
                {
                    self.delegate.setModelChipDictionary("\(xCount - x - 1),\(y)", info: dictionary["\(x),\(y)"]!)
                }
                //yだけ回転
                else if(xRotation == false && yRotation == true)
                {
                    self.delegate.setModelChipDictionary("\(x),\(yCount - y - 1)", info: dictionary["\(x),\(y)"]!)
                }
                
            }
            y = 0
        }
        
    }
    
    internal class func draw()
    {
        var dictionary:Dictionary<String, ChipInfo> = self.delegate.getModelChipDictionary()
        println("MapUtil::draw")
        var gridX:Int = 0
        var gridY:Int = 0
        var zPosition:CGFloat = 0
        while((dictionary["\(gridX),\(gridY)"]) != nil)
        {
            while(dictionary["\(gridX),\(gridY)"] != nil)
            {
                addChip(gridX, gridY: gridY, z: 0, info: dictionary["\(gridX),\(gridY)"]!, zPosition:zPosition)
                zPosition++
                gridX++
            }
            gridX = 0;
            gridY++
        }
        
    }
}