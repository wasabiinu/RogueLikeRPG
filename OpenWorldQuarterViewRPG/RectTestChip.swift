//
//  RectTestChip.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/07.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//レクタングルの分割テスト用チップクラスです

import SpriteKit

class RectTestChip: MapChip {
    //num:Int チップ番号を指定します
    init(let num:Int) {
        let imageName:String = "ground.rectcheck." + String(num) + ".png";
        super.init(imageName: imageName)
    }
}