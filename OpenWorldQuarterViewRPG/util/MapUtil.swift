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
    
    class var delegate:MapDelegate
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

    class func setDelegate(delegate:MapDelegate)
    {
        println("MapUtil::setDelegate")
        self.delegate = delegate
    }
    
    //受け取ったサイズのレクタングルとタイプでエリアを作って、受け取った親に加えます
    class func createRectArea(let rect:CGRect, let type:Int)
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
    
    class func addChip(gridX:Int, gridY:Int, z:Int, info:ChipInfo)
    {
        var groundChip:MapChip = RectTestChip(num:info.type)
        groundChip.position(gridX, gridY: gridY, z: z)
        self.delegate.getModelNode().addChild(groundChip.node)
    }
    
    //レクタングルを縦横どちらかランダムに2分割して返します
    class func twoSplitRect(let OriginalRect:CGRect) -> (CGRect, CGRect)
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
    
    //分割を繰り返す
    class func repeatSplitRectangle()
    {
        var OriginalRect:CGRect = CGRectMake(0, 0, 100, 100)
        var rect1:CGRect = CGRectMake(0, 0, 100, 100)
        var rect2:CGRect = CGRectMake(0, 0, 100, 100)
        var i:Int = 0;
        var minWidth:Int = 2;
        var minHeight:Int = 2;
        for (var width:Int = Int(rect1.size.width), height:Int = Int(rect1.size.height); width > minWidth && height > minHeight && i < 8; i++)
        {
            (rect1, rect2) = MapUtil.twoSplitRect(rect1)
            
            
            //rect1をDictionaryに登録する
            registChipInfo(rect1, type: i)
            
            width = Int(rect2.size.width)
            height = Int(rect2.size.height)
            
            
            rect1 = rect2
        }
        registChipInfo(rect1, type: i)
    }
    
    //レクタングルをDictionaryに登録する
    class func registChipInfo(let rect:CGRect, let type:Int)
    {
        
        println("MapUtil::registChipInfo::x:\(rect.origin.x),y:\(rect.origin.y)")
        for (var registWidth:CGFloat = 0; registWidth < rect.size.width; registWidth++)
        {
            for (var registHeight:CGFloat = 0; registHeight < rect.size.height; registHeight++)
            {
                self.delegate.setModelChipDictionary("\(Int(registWidth + rect.origin.x)),\(Int(registHeight + rect.origin.y))", info: ChipInfo(type: type))
            }
        }
        println("MapUtil::registChipInfo::end::\(self.delegate.getModelChipDictionary().count)")
    }
    
    class func draw()
    {
        var dictionary:Dictionary<String, ChipInfo> = self.delegate.getModelChipDictionary()
        println("MapUtil::draw")
        var gridX:Int = 0;
        var gridY:Int = 0;
        while((dictionary["\(gridX),\(gridY)"]) != nil)
        {
            while(dictionary["\(gridX),\(gridY)"] != nil)
            {
                addChip(gridX, gridY: gridY, z: 0, info: dictionary["\(gridX),\(gridY)"]!)
                gridY++
            }
            gridY = 0;
            gridX++
        }
    }
}