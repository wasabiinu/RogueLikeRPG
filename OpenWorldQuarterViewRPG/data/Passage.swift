//
//  Passage.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/16.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit


//originRectが1つ定まっていて
//intercectRectの配列があり、
//それぞれ、intercectRectには、passageRectの配列を持つ
//アクセスの仕方
//Passage.originRect -> CGRect
//Passage.passages[intercect].intercect -> CGRect
//Passage.passages[intercect].passageList -> [CGRect]

internal class Passage {
    internal var passages:Dictionary<HashableRect, Passages>
    internal var originRect:CGRect
    init (originRect:CGRect)
    {
        self.originRect = originRect
        self.passages = Dictionary<HashableRect, Passages>()
    }
    
    internal func setPassage(intersectRect:HashableRect, passageRect:CGRect)
    {
        if (passages[intersectRect] == nil)
        {
            self.passages[intersectRect] = Passages(intercect: intersectRect)
        }
         self.passages[intersectRect]!.passageList.append(passageRect)
    }
    
    internal func getRandomPassage() -> [CGRect]
    {
        var array:[CGRect] = [CGRect]()
        for p:Passages in passages.values
        {
            var passageList:[CGRect] = p.passageList
            var count:Int = passageList.count
            var max:Int = Int(Random.random(UInt32(count)))
            var cgRect:CGRect = passageList[max]
            array.append(cgRect)
        }
        
        return array
    }
    
    
    internal struct Passages {
        internal var intercect:CGRect
        internal var passageList:[CGRect]
        init (intercect:HashableRect)
        {
            self.intercect = intercect.cgRect
            self.passageList = [CGRect]()
        }
    }
}