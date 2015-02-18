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