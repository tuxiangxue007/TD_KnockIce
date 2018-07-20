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
    var iSpace:Int!
    var iTag:Int!
    
    func layout() {
        setPhysicsBody(iSpace: iSpace, iTag: iTag)
    }
    
    
    func setPhysicsBody(iSpace:Int,iTag:Int){
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: self.imageName), size: self.size)
        self.physicsBody?.node?.name = String(iSpace * 1000 + iTag)
        self.physicsBody?.categoryBitMask = TD_Block1Category
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.density = 0.5
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.contactTestBitMask = TD_ProtagonistCategory
        self.zPosition = 1
        self.physicsBody?.restitution = 0.75
    }
}
