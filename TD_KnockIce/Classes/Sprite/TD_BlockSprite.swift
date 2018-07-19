//
//  TD_BlockSprite.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_BlockSprite: SKSpriteNode {
    var blockType:Int!//0、铁快（不可毁坏） 1、完整的砖（需要撞击2下） 2、半块砖（只需要攻击一下）
    var imageName:String!
    var iSpaceHeight:Int!

}
