//
//  UIUtil.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/09.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

class UIUtil {
    
    class var delegate:UIDelegate
        {
        set {
        ClassProperty.delegate = newValue
        }
        get {
            return ClassProperty.delegate
        }
    }
    
    class var startPos:CGPoint
        {
        set {
        ClassProperty.startPos = newValue
        }
        get {
            return ClassProperty.startPos
        }
    }
    
    class var pinchRect:CGRect
        {
        set {
        ClassProperty.pinchRect = newValue
        }
        get {
            return ClassProperty.pinchRect
        }
    }
    
    private struct ClassProperty {
        static var delegate:UIDelegate!
        static var startPos:CGPoint!;
        static var pinchRect:CGRect = CGRectMake(0, 0, 0, 0);
    }
    
    class func setDelegate(delegate:UIDelegate)
    {
        println("MapUtil::setDelegate")
        self.delegate = delegate
    }
    
    class func setStartPos(touches: NSSet)
    {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(delegate.getModelScene())
            startPos = location;
            /*
            var node:SKNode! = delegate.getModelScene().nodeAtPoint(location);
            if(node != nil){
                if(node.name=="world"){
                    //startPos = location;
                }
            }
            */
        }
    }
    
    class func createPinchRect(touches:NSSet, node:SKNode) -> CGRect
    {
        //println("createPinchRect")
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
                //println("createPinchRect ended")
                return CGRectMake(0, 0, width, height)
            }
        }
        //println("createPinchRect ended null")
        return CGRectMake(0, 0, 0, 0)
    }
    
    class func pinchInOut(touches: NSSet)
    {
        //ピンチインアウトでズームインアウト
        if (touches.count == 2)
        {
            if (pinchRect != CGRectMake(0, 0, 0, 0))
            {
                var endRect = createPinchRect(touches, node:delegate.getModelScene())
                if (endRect.size.width * endRect.size.height > pinchRect.size.width * pinchRect.size.height)
                {
                    println("pinchOut")
                    delegate.getModelNode().xScale *= 1.02
                    delegate.getModelNode().yScale *= 1.02
                }
                else if (pinchRect.size.width * pinchRect.size.height > endRect.size.width * endRect.size.height)
                {
                    println("pinchIn")
                    delegate.getModelNode().xScale /= 1.02
                    delegate.getModelNode().yScale /= 1.02
                }
                //centerOnNode(myWorld)
            }
            pinchRect = createPinchRect(touches, node:delegate.getModelScene())
        }
    }
    
    class func drag(touches: NSSet, touchPos:CGPoint)
    {
        //マップビューのドラッグ移動
        if (touches.count == 1 || touches.count == 3)
        {
            if (startPos.x - touchPos.x < 50 && startPos.x - touchPos.x > -50 && startPos.y - touchPos.y < 50 && startPos.y - touchPos.y > -50)
            {
                delegate.getModelNode().position.x -= startPos.x - touchPos.x
                delegate.getModelNode().position.y -= startPos.y - touchPos.y
                startPos.x -= startPos.x - touchPos.x
                startPos.y -= startPos.y - touchPos.y
            }
        }
    }
}