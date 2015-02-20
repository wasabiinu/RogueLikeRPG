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
        //var count:Int = 0
        _for: for p:Passages in passages.values
        {
            var passageList:[CGRect]? = p.passageList
            
            var count:Int = Int(passageList!.count)
            
            
            if (count == 0)
            {
                continue _for
            }
            else if (count == 1)
            {
                var cgRect:CGRect = passageList![0]
                array.append(cgRect)
                continue _for
            }
           
            
            var max:Int = Int(Random.random(UInt32(count)))
            //通路を2つ取得する
            var cgRect1:CGRect = passageList![max]
            
            max = Int(Random.random(UInt32(count)))
            
            var cgRect2:CGRect = passageList![max]
            
            
            
            //1グリッドの場合
            if(
                cgRect1.size.width == 1.0 && cgRect1.size.height == 1.0
                || cgRect1.size.width == 1.0 && cgRect1.size.height < 3.0
                || cgRect1.size.width < 3.0 && cgRect1.size.height == 1.0
                )
            {
                //結合しない
                array.append(cgRect1)
                continue _for
            }
            
            //ぐねぐね曲がる通路
            var startRect:CGRect
            var goalRect:CGRect
            var joinRect:CGRect
            
            //左下に伸びる通路の場合
            if(cgRect1.size.height == 1)
            {
                //continue _for
                var splitWidth:CGFloat = CGFloat(Random.random(UInt32(cgRect1.size.width - 2))) + 1
                startRect = CGRectMake(cgRect1.origin.x, cgRect1.origin.y, splitWidth, 1)
                goalRect = CGRectMake(cgRect1.origin.x + splitWidth, cgRect2.origin.y, cgRect2.size.width - splitWidth, 1)
                //レクタングルの位置によって、参照する基準点を変える必要がある
                if(cgRect1.origin.y < cgRect2.origin.y)
                {
                    joinRect = CGRectMake(cgRect1.origin.x + splitWidth, cgRect1.origin.y, 1,cgRect2.origin.y - cgRect1.origin.y)
                }
                else
                {
                    joinRect = CGRectMake(cgRect1.origin.x + splitWidth, cgRect2.origin.y, 1,cgRect1.origin.y - cgRect2.origin.y + 1)
                }
                
            }
            //右下に伸びる通路の場合
            else
            {
                //continue _for
                var splitHeight:CGFloat = CGFloat(Random.random(UInt32(cgRect1.size.height - 2))) + 1
                startRect = CGRectMake(cgRect1.origin.x, cgRect1.origin.y, 1, splitHeight)
                goalRect = CGRectMake(cgRect2.origin.x, cgRect1.origin.y + splitHeight, 1, cgRect2.size.height - splitHeight)
                //レクタングルの位置によって、参照する基準点を変える必要がある
                if(cgRect1.origin.x < cgRect2.origin.x)
                {
                    joinRect = CGRectMake(cgRect1.origin.x, cgRect1.origin.y + splitHeight, cgRect2.origin.x - cgRect1.origin.x, 1)
                }
                else
                {
                    joinRect = CGRectMake(cgRect2.origin.x,cgRect1.origin.y + splitHeight,cgRect1.origin.x - cgRect2.origin.x + 1, 1)
                }
            }
            
            
            array.append(startRect)
            array.append(goalRect)
            array.append(joinRect)
        
        
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