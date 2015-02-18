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

internal struct Passage {
    internal var passages:Dictionary<HashableRect, Passages>
    internal var originRect:CGRect
    init (originRect:CGRect)
    {
        self.originRect = originRect
        self.passages = Dictionary<HashableRect, Passages>()
        passages[HashableRect(x:0,y:0,width:0,height:0)] = Passages(intercect:HashableRect(x:0,y:0,width:0,height:0))
    }
    
    internal func setPassage(intersectRect:HashableRect, passageRect:CGRect)
    {
        var p:Passages = Passages(intercect: intersectRect)
        //if (passages[intersectRect] == nil)
        //{
            passages[intersectRect] = p
        //}
        var pass:Passages = passages[intersectRect]!
        pass.passageList.append(passageRect)
        
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