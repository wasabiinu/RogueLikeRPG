//
//  Sabar.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/22.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import SpriteKit
internal class Sabar: Human
{
    init() {
        super.init(imageName: "avatar.human.saber.default.png")
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.0.png"))
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.1.png"))
        super.walk2Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.2.png"))
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.0.png"))
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.1.png"))
        super.walk1Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.2.png"))
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.0.png"))
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.1.png"))
        super.walk3Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.0.2.png"))
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.2.0.png"))
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.2.1.png"))
        super.walk4Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.2.2.png"))
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.2.0.png"))
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.2.1.png"))
        super.walk5Textures.append(SKTexture(imageNamed: "avatar.human.saber.walk.2.2.png"))
    }
}