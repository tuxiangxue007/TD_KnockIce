//
//  PrefixHeader.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit

let TD_Screen = UIScreen.main.bounds.size
let TD_ScreenW = TD_Screen.width
let TD_ScreenH = TD_Screen.height
let TD_BlockH = 15.0

let TD_BlockW_PT = (Float64(TD_ScreenW) - TD_BlockH * 10.0)/22.0


let TD_WorldCategory    : UInt32 = 0x1 << 1
let TD_SeaCategory    : UInt32 = 0x1 << 2
let TD_ProtagonistCategory : UInt32 = 0x1 << 3
let TD_Block1Category    : UInt32 = 0x1 << 4
let TD_Block0Category      : UInt32 = 0x1 << 5
let TD_MonsterCategory      : UInt32 = 0x1 << 6


struct PhysicsCategory {
    static let Crocodile: UInt32 = 1
    static let VineHolder: UInt32 = 2
    static let Vine: UInt32 = 4
    static let Prize: UInt32 = 8
}

