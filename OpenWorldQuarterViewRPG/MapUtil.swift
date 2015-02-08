//
//  MapUtil.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/07.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//Mapで使う機能を実装します

import SpriteKit

class MapUtil {
    //受け取ったサイズのレクタングルとタイプでエリアを作って、受け取った親に加えます
    class func createRectArea(let world:SKNode, let rect:CGRect, let type:Int)
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
                world.addChild(groundChip.node)
            }
        }
    }
    
    //レクタングルを縦横どちらかランダムに2分割して返します
    class func splitRect(let OriginalRect:CGRect) -> (CGRect, CGRect)
    {
        var direction:Int = Int(arc4random_uniform(2))
        var rect1:CGRect
        var rect2:CGRect
        
        
        //横分割
        if (direction == 1)
        {
            //横幅の1/2
            var seedWidth:UInt32 = UInt32(OriginalRect.size.width  / 2)
            //横幅の1/4〜3/4にする
            //横幅の0〜1/2を作り、1/4を加える
            var splitWidth:CGFloat = CGFloat(arc4random_uniform(seedWidth) + seedWidth / 2)
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
            var splitHeight:CGFloat = CGFloat(arc4random_uniform(seedHeight) + seedHeight / 2)
            rect1 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y, OriginalRect.size.width, splitHeight)
            rect2 = CGRectMake(OriginalRect.origin.x, OriginalRect.origin.y + splitHeight, OriginalRect.size.width, OriginalRect.size.height - rect1.size.height)
        }
        
        return (rect1, rect2)
    }
}