//
//  HashableRect.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/17.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import SpriteKit

internal class HashableRect {
    internal var origin:Origin
    internal var size:Size
    internal var cgRect:CGRect
    /* {
        get {
            return CGRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height)
        }
    }*/
    
    init (let x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)
    {
        self.origin = Origin(x: x, y: y)
        self.size = Size(width: width, height:height)
        self.cgRect = CGRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height)
    }
    
    /*
    convenience init (let cgRect:CGRect)
    {
        init(cgRect.orign.x, cgRect.origin.y, cgRect.size.width, cgRect.size.height)
        //self.origin = Origin(x: cgRect.origin.x, y:cgRect.origin.y)
        //self.size = Size(width: cgRect.size.width, height:cgRect.size.height)
    }
*/
    
    internal struct Origin {
        internal var x:CGFloat
        internal var y:CGFloat
        init (let x:CGFloat, y:CGFloat)
        {
            self.x = x
            self.y = y
        }
    }
    
    internal struct Size {
        internal var width:CGFloat
        internal var height:CGFloat
        init (let width:CGFloat, height:CGFloat)
        {
            self.width = width
            self.height = height
        }
    }
}

extension HashableRect: Hashable {
    var hashValue:Int {
        return origin.x.hashValue ^ origin.y.hashValue ^ size.width.hashValue ^ size.height.hashValue
    }
}

func == (lhs:HashableRect, rhs:HashableRect) -> Bool {
    return lhs.origin.x == rhs.origin.x && lhs.origin.y == rhs.origin.y && lhs.size.width == rhs.size.width && lhs.size.height == rhs.size.height
}