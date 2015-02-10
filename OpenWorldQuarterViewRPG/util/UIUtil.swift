//
//  UIUtil.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/09.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class UIUtil {
    class func createPinchRect(touches:NSSet, node:SKNode) -> CGRect
    {
        println("createPinchRect")
        println(touches)
        println(touches.count)
        println(node)
        if (touches.count == 2)
        {
            var touchArray:Array<UITouch> = Array<UITouch>()
            var touchNum:Int = 0
            for pinchTouch in touches
            {
                if (pinchTouch is UITouch)
                {
                    touchArray.append(pinchTouch as UITouch)
                    //touchArray[touchNum] = pinchTouch as UITouch
                }
                touchNum++
            }
            if (touchArray.count == 2)
            {
                var width:CGFloat = touchArray[0].locationInNode(node).x - touchArray[1].locationInNode(node).x
                if (width < 0)
                {
                    width *= -1
                }
                var height:CGFloat = touchArray[0].locationInNode(node).y - touchArray[1].locationInNode(node).y
                if (height < 0)
                {
                    height *= -1
                }
                println("createPinchRect ended")
                return CGRectMake(0, 0, width, height)
            }
        }
        println("createPinchRect ended")
        return CGRectMake(0, 0, 0, 0)
    }
}