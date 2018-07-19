//
//  TD_ProtagonistSprite.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_ProtagonistSprite: SKSpriteNode {
    private var direction : Int?        //行走方向 0、站立 1、向左运动 2、向右运动
    var isLeap=false                    //是否未跳跃状态
    var iBanDirection:Int?              //禁止方向  1、没有禁止 1、禁止向左 2、禁止向右
    func creatSprite() {
        
        move()
    }
    func move(){
        var x = position.x
        if direction == 1 && iBanDirection != 1{
            x -= 2
        }else if direction == 2 && iBanDirection != 2{
            x += 2
        }else {
            
        }
        
        let duration = 0.05;
        let actionMove = SKAction.moveTo(x: x, duration: duration)

        self.run(actionMove) {
            self.move()
        }
    }
    func setDirection(direction:Int) {
        self.direction = direction
    }
    func moveDown() {
        let actionMove = SKAction.moveTo(y: self.position.y - CGFloat(TD_BlockH * 6), duration: 0.25)
        self.run(actionMove) {
            
        }
    }
}
