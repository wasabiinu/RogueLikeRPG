//
//  TimerModel.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/25.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
internal class TimeModel
{
    init ()
    {
        //タイマーマネージャークラスを使う関数を順番に追加していく
        //主人公を動かすのを追加
        TimeManager.add(HeroManager.action, anyObjects: HeroManager.getHero())
    }
}