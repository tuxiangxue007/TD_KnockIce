//
//  TD_MonsterSprite.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_MonsterSprite: SKSpriteNode {
    var isLeft=true
    var iTimeDelay:Int = 0
    var superSpace:SKNode?
    
    func layout() {
        let time: TimeInterval = Double(iTimeDelay)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            print("1 秒后输出")
            self.move(self.isLeft)
        }
    }
    func move(_ isLeftMove:Bool){

        if isLeftMove{
            let impulse =  CGVector(dx: 2, dy: 0)//向右移动
            self.physicsBody?.applyImpulse(impulse)
            self.physicsBody?.affectedByGravity = true
//            let actionMove = SKAction.moveTo(x: TD_ScreenW, duration: 5)
//
//            self.run(actionMove) {
//                self.move(false)
//            }
        }else{
            let actionMove = SKAction.moveTo(x: 0, duration: 5)

            self.run(actionMove) {
//                self.move(true)
                let impulse =  CGVector(dx: -2, dy: 0)//向左移动
                self.physicsBody?.applyImpulse(impulse)
                self.physicsBody?.affectedByGravity = true
            }
        }
    }

    func getMonsterWithBlockIndex(){
        
    }
    
}


