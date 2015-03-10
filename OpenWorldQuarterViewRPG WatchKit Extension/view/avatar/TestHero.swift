//
//  TestHero.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/22.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import SpriteKit
internal class TestHero: Human
{
    init() {
        super.init(imageName: "avatar.human.testhero.walk.1.0.png")
        
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.1.1.png"))
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.1.0.png"))
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.1.2.png"))
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.1.0.png"))
        
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.2.1.png"))
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.2.0.png"))
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.2.2.png"))
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.2.0.png"))
        
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.3.1.png"))
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.3.0.png"))
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.3.2.png"))
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.3.0.png"))
        
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.4.1.png"))
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.4.0.png"))
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.4.2.png"))
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.4.0.png"))
        
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.5.1.png"))
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.5.0.png"))
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.5.2.png"))
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.testhero.walk.5.0.png"))
    }
}