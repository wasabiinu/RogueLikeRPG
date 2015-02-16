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
    internal var passages:Dictionary<CGRect, Passages>
    internal var originRect:CGRect
    init (originRect:CGRect)
    {
        self.originRect = originRect
        self.passages = Dictionary<CGRect, Passages>()
    }
    
    internal func setPassage(intersectRect:CGRect, passageRect:CGRect)
    {
        if (passages[intersectRect] == nil)
        {
            passages[intersectRect] = Passages(intersectRect)
        }
        passages[intersectRect].passageList.appendTo(passageRect)
    }
    
    
    internal struct Passages {
        internal var intercect:CGRect
        internal var passageList:[CGRect]
        init (intercect:CGRect)
        {
            self.intercect = intercect
            self.passageList = [CGRect]()
        }
    }
}