//
//  InterfaceController.swift
//  OpenWorldQuarterViewRPG WatchKit Extension
//
//  Created by 横山 優 on 2015/03/10.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import WatchKit
import SpriteKit
import Foundation
import OpenWorldQuarterViewRPG


class InterfaceController: WKInterfaceController {

    private var mapModel:MapModel!
    private var uiModel:UIModel!
    private var timeModel:TimeModel!
    //private var myWorld:SKNode = SKNode()
    //private var myUI:SKNode = SKNode()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        //var size:CGSize = view.frame.size
        
        //self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        //self.anchorPoint = CGPointMake(0.5, 1)
//        myWorld.name = "world"
//        myWorld.xScale = 1.5
//        myWorld.yScale = 1.5
//        
//        myUI.name = "ui"
//        myUI.xScale = 1
//        myUI.yScale = 1
//        
//        //var test:CGRect = CGRectMake()
//        
//        var camera:SKNode = SKNode()
//        camera.name = "camera"
//        myWorld.addChild(camera)
        
        //mapModel = MapModel(node: myWorld, scene:self)
        //uiModel = UIModel(node: myWorld, ui:myUI, scene:self)
        
        //timeModel = TimeModel()
        
        //self.addChild(myWorld)
        //self.addChild(myUI)
       // MapUtil.onTouchCursor(-1)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
