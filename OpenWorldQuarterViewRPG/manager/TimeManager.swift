//
//  TimeManager.swift
//  OpenWorldQuarterViewRPG
//
//  Created by 横山 優 on 2015/02/24.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//1操作ある度に時間を1つ進める　＝　登録された関数を実行するクラス

import Foundation
internal class TimerManager
{
    private struct ClassProperty {
        static var funcArray:[(Void, [AnyObject]) -> Void] = []
        static var optionArray:[[AnyObject]] = [[AnyObject]]()
        static var callbackCount:Int = 0
    }
    
    internal class var funcArray:[(Void, [AnyObject]) -> Void]
        {
        set {
            ClassProperty.funcArray = newValue
        }
        get {
            return ClassProperty.funcArray
        }
    }
    
    internal class var optionArray:[[AnyObject]]
        {
        set {
        ClassProperty.optionArray = newValue
        }
        get {
            return ClassProperty.optionArray
        }
    }
    
    internal class var callbackCount:Int
        {
        set {
        ClassProperty.callbackCount = newValue
        }
        get {
            return ClassProperty.callbackCount
        }
    }
    
    init()
    {
        
    }
    
    /**
    *
    *　タイマーマネージャーに実行したい関数を追加する
    *　指定する関数はFunction(callBack:Void, OptionArray)の形式を守る
    */
    internal class func add(f:(Void, [AnyObject]) -> Void, anyObject:AnyObject...)
    {
        var addArray:[AnyObject] = [AnyObject]()
        
        for a:AnyObject in anyObject
        {
            addArray.append(a)
        }
        
        funcArray.append(f)
        optionArray.append(addArray)
    }
    
    /**
    * 登録した関数を順に実行する
    */
    internal class func start()
    {
        callbackCount = 0
        //ロックする
        
        //格納された関数を順に実行する
        funcArray[callbackCount](onCallback(), optionArray[callbackCount])
    }
    
    /**
    * 登録した関数からのコールバックがあったとき
    */
    internal class func onCallback()
    {
        self.callbackCount++
        //登録された関数の残りを確認する
        if( self.callbackCount >= funcArray.count)
        {
            //ロック解除する
            
            //念のため関数カウントを初期化する
            self.callbackCount = 0
        }
        else
        {
            //格納された関数を順に実行する
            funcArray[callbackCount](onCallback(), optionArray[callbackCount])
        }
    }
}