//
//  TD_SpaceView.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_SpaceView: SKNode {
    var iSpace:Int!
    var iHeight:Int!
//    var blockArr=[TD_BlockSprite]()
    var blockDict = [Int:TD_BlockSprite]()
    
    func creatSpace(){


        let iSpaceLab = SKLabelNode(text: String( iSpace))
        iSpaceLab.position = CGPoint.init(x: 20, y: 40)
        iSpaceLab.fontColor = UIColor.white
        addChild(iSpaceLab)

        for i in 0..<6 {
            if(i == 0 ){
                 creatStartEndBlock(isStart: false, y: CGFloat(TD_BlockH * Float64(5 - i)))
            }else if(i == 5){
                 creatStartEndBlock(isStart: true, y: CGFloat(TD_BlockH * Float64(5 - i)))
            }
        }
        
        
        creatMonster()
    }
    func creatMonster() {
        
        let iTimeDelay = arc4random() % 20
        if iTimeDelay < 10 {
            let isLeft = arc4random()%2
            
            var mPosition:CGPoint
            let monstrSprote = TD_MonsterSprite(imageNamed: "seal")
            monstrSprote.iTimeDelay = Int(iTimeDelay)
            if isLeft == 0{
                mPosition = CGPoint.init(x: -TD_BlockW_PT * 2, y: TD_BlockW_PT)
                monstrSprote.isLeft = true
            }else{
                mPosition = CGPoint.init(x: Double(TD_ScreenW) + TD_BlockW_PT * 2, y: TD_BlockW_PT)
                monstrSprote.isLeft = false
            }
            monstrSprote.superSpace = self
            monstrSprote.position = mPosition
            monstrSprote.size = CGSize.init(width: TD_BlockW_PT * 2, height: TD_BlockW_PT * 2)
            monstrSprote.layout()
            addChild(monstrSprote)
        }
    }

    
    func creatStartEndBlock(isStart:Bool,y:CGFloat){
        for num in 0..<32 {
            var blockSprite = TD_BlockSprite()
            
            if (num < 5 || num >= 27){
                if (isStart){
                    blockSprite = TD_BlockSprite(imageNamed: "hard")
                    blockSprite.iSpaceHeight = iHeight
                    blockSprite.imageName = "hard"
                    blockSprite.blockType = 0
                    var x = CGFloat(TD_BlockH / 2.0)
                    if (num >= 27){
                        x = x + CGFloat(TD_BlockH * 5.0) + CGFloat(TD_BlockW_PT * 22) + CGFloat(TD_BlockH * Float64(num - 27))
                    }else{
                        x = x + CGFloat(TD_BlockH * Float64(num))
                    }
                    blockSprite.position = CGPoint.init(x: x, y: y + CGFloat(TD_BlockH / 2))
                    blockSprite.size = CGSize.init(width: TD_BlockH, height: TD_BlockH)
                    
                    addChild(blockSprite)
//                    blockArr.append(blockSprite)
                    blockDict[100 + num] = blockSprite
                }
            }
            else{
                if (isStart){
                    blockSprite = TD_BlockSprite(imageNamed: "block_1")
                    blockSprite.iSpaceHeight = iHeight
                    blockSprite.imageName = "block_1"
                    blockSprite.blockType = 1
                    var x = CGFloat(TD_BlockH * 5.0 )
                    x = x + CGFloat(TD_BlockW_PT) * CGFloat(num - 5)
                    blockSprite.position = CGPoint.init(x: x + CGFloat(TD_BlockW_PT / 2.0), y: y +  y + CGFloat(TD_BlockH / 2))
                    blockSprite.size = CGSize.init(width: TD_BlockW_PT, height: TD_BlockH)
                    addChild(blockSprite)
//                    blockArr.append(blockSprite)
                    blockDict[100 + num] = blockSprite
                }else{
                    let arc = arc4random() % 3
                    if(arc == 1){
                        blockSprite = TD_BlockSprite(imageNamed: "block_1")
                        blockSprite.iSpaceHeight = iHeight
                        blockSprite.blockType = 1
                        blockSprite.imageName = "block_1"
                        var x = CGFloat(TD_BlockH * 5.0 )
                        x = x + CGFloat(TD_BlockW_PT) * CGFloat(num - 5)
                        blockSprite.position = CGPoint.init(x: x + CGFloat(TD_BlockW_PT / 2.0), y: y + CGFloat(TD_BlockH / 2))
                        blockSprite.size = CGSize.init(width: TD_BlockW_PT, height: TD_BlockH)
                        addChild(blockSprite)
//                        blockArr.append(blockSprite)
                        blockDict[200 + num] = blockSprite
                    }else if (arc == 2){
                        blockSprite = TD_BlockSprite(imageNamed: "block_2")
                        blockSprite.iSpaceHeight = iHeight
                        blockSprite.blockType = 2
                        blockSprite.imageName = "block_2"
                        var x = CGFloat(TD_BlockH * 5.0 )
                        x = x + CGFloat(TD_BlockW_PT) * CGFloat(num - 5)
                        blockSprite.position = CGPoint.init(x: x + CGFloat(TD_BlockW_PT / 2.0), y: y + CGFloat(TD_BlockH / 2 + TD_BlockH / 4))
                        blockSprite.size = CGSize.init(width: TD_BlockW_PT, height: TD_BlockH / 2)
                        addChild(blockSprite)
//                        blockArr.append(blockSprite)
                        blockDict[200 + num] = blockSprite
                    }
                }
            }
        }
    }
    func impact(blockPosition:CGPoint){
        for dic in blockDict {
            let key = dic.key
            let block = dic.value
//        }
//        for i in 0..<blockArr.count {
//            let block = blockArr[i]
            if Int(block.position.x) == Int(blockPosition.x) && Int(block.position.y) == Int(blockPosition.y){
//                NSLog("impact block:%@",block)
                if block.blockType == 1{//撞击到完整的砖块
//                    let bPosition = CGPoint.init(x:  block.position.x, y: block.position.y + block.size.height / 4)
                    removeChildren(in: [block])
//                    blockArr.remove(at: i)
                    blockDict.removeValue(forKey: key)
//                    NSLog("remove block:%@",block)

//                    addChild(<#T##node: SKNode##SKNode#>)
//                    block = TD_BlockSprite(imageNamed: "block_2")
//                    block.iSpaceHeight = iHeight
//                    block.blockType = 2
//                    block.imageName = "block_2"
//                    block.position = bPosition
//                    block.size = CGSize.init(width: TD_BlockW_PT, height: TD_BlockH / 2)
//                    addChild(block)
//                    blockArr.replaceSubrange(Range(i..<i+1), with: [block])
                }else if block.blockType == 2{//撞击到半块的砖块
                    removeChildren(in: [block])
//                    blockArr.remove(at: i)
                    blockDict.removeValue(forKey: key)

//                    NSLog("remove block:%@",block)

                }
                return
            }
        }
    }
    func moveDown() {
        iHeight = iHeight - 1
        for dic in blockDict {
            let block = dic.value
            block.iSpaceHeight = iHeight
        }
        
        let actionMove = SKAction.moveTo(y: self.position.y - CGFloat(TD_BlockH * 6), duration: 0.25)
        self.run(actionMove) {
            if self.iHeight < 0{
                self.removeFromParent()
            }
        }
    }
}
