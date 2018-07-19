//
//  TD_GameScene.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

import UIKit
class TD_GameScene: SKScene ,SKPhysicsContactDelegate,SKSceneDelegate{
    var highBview:SKNode!
    var lowBview:SKNode!
    
    var iSpace:Int!
    
    var seaSprite:SKSpriteNode!                             //大海
    var protagonistSprite:TD_ProtagonistSprite!             //主角

    var stopStartLab:SKLabelNode!
    var leftLab:SKLabelNode!
    var rightLab:SKLabelNode!
    var leapLab:SKLabelNode!
    
    var  spaceViewArr=[TD_SpaceView]()
    
    var isStartGame = false

    override func didMove(to view: SKView) {
         iSpace = 0
//         backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        delegate = self;
         creatScene();
    }
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    func creatScene() {

        
        initBView()
        var y = 30.0
        for num in 0 ..< 4 {
            NSLog("%d",num)
            let spaceView = TD_SpaceView()
            
            spaceView.position = CGPoint.init(x: 0, y: y)
            iSpace =  iSpace + 1
            spaceView.iSpace =  iSpace
            spaceView.iHeight = num
            spaceView.creatSpace()
            spaceViewArr.append(spaceView)
            lowBview.addChild(spaceView)
            
            y += TD_BlockH * 6
        }
        initSeaSprite()
        initProtagonistSprite()
        
        creatBtn()
        creatHandle()
        
        
        setPhysicsBody()    //设置物理世界

    }

    func initBView(){
        highBview = SKNode()
        lowBview = SKNode()
        addChild(lowBview)
        addChild(highBview)
        
    }
    func initSeaSprite(){
        seaSprite = SKSpriteNode(imageNamed:"sea")
        seaSprite.position = CGPoint.init(x: TD_ScreenW / 2, y: 30 / 2)
        seaSprite.size = CGSize.init(width: TD_ScreenW, height: 30)
        addChild( seaSprite)
    }
    func initProtagonistSprite(){
        protagonistSprite = TD_ProtagonistSprite(imageNamed: "protagonist")
        protagonistSprite.position = CGPoint.init(x: 150, y: 30 + TD_BlockH + TD_BlockH * 3 / 2.0 + 2)
        protagonistSprite.size = CGSize.init(width: TD_BlockW_PT, height: TD_BlockH * 3)
        protagonistSprite.zPosition = 1
        protagonistSprite.creatSprite()
        highBview.addChild( protagonistSprite)
//        addChild(protagonistSprite)
        
       
        
        
        
//        let pinJoint = SKPhysicsJointPin.joint(withBodyA: protagonistSprite.physicsBody!, bodyB: seaSprite.physicsBody!, anchor: CGPoint.init(x: 400, y: 300))
//        physicsWorld.add(pinJoint)
    }
    
    func newSpaceView(){
        let spaceView = TD_SpaceView()
        spaceView.position = CGPoint.init(x: 0, y: 30 + TD_BlockH * 6 * 4)
        iSpace =  iSpace + 1
        spaceView.iSpace =  iSpace
        spaceView.iHeight = 4
        spaceView.creatSpace()
        spaceViewArr.append(spaceView)
        lowBview.addChild(spaceView)
    }
    
    func creatBtn(){
        stopStartLab = SKLabelNode(text: "开始")
        stopStartLab.name = "stopStartLab"
        stopStartLab.position = CGPoint.init(x: 50, y: TD_ScreenH - 50)
        highBview.addChild(stopStartLab)
    }
    func creatHandle(){
        leftLab = SKLabelNode(text: "左")
        leftLab.name = "leftLab"
        leftLab.position = CGPoint.init(x: 50, y: 50)
        highBview.addChild(leftLab)
        
        rightLab = SKLabelNode(text: "右")
        rightLab.name = "rightLab"
        rightLab.position = CGPoint.init(x: 150, y: 50)
        highBview.addChild(rightLab)
        
        leapLab = SKLabelNode(text: "跳跃")
        leapLab.name = "leapLab"
        leapLab.position = CGPoint.init(x: TD_ScreenW - 50, y: 50)
        highBview.addChild(leapLab)
    }
    
    
    func setPhysicsBody(){
        
        
        physicsWorld.gravity = CGVector.init(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1.5
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
        
        seaSprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "sea"), size: seaSprite.size)
        seaSprite.physicsBody?.usesPreciseCollisionDetection = true

        seaSprite.physicsBody?.categoryBitMask = TD_SeaCategory
        seaSprite.physicsBody?.collisionBitMask = 0
        seaSprite.physicsBody?.density = 0.5
        seaSprite.physicsBody?.isDynamic = false
//        seaSprite.physicsBody?.affectedByGravity = false
        seaSprite.physicsBody?.allowsRotation = false;
        seaSprite.physicsBody?.contactTestBitMask = TD_SeaCategory
//        seaSprite.zPosition = 1
        
        protagonistSprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "protagonist"), size: protagonistSprite.size)
//        protagonistSprite.physicsBody?.categoryBitMask = TD_ProtagonistCategory
        protagonistSprite.physicsBody?.collisionBitMask = 0
        protagonistSprite.physicsBody?.density = 0.5
        protagonistSprite.physicsBody?.usesPreciseCollisionDetection = true
        protagonistSprite.physicsBody?.contactTestBitMask = TD_ProtagonistCategory
        protagonistSprite.physicsBody?.affectedByGravity = false
        
        setSpaceViewBody()
    }
    func setSpaceViewBody(){
        for spaceView in spaceViewArr {
            for block in spaceView.blockArr{
                
                block.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: block.imageName), size: block.size)
                
                var name = ""
                if block.iSpaceHeight == 1{
                    name = "1"
                }else if block.iSpaceHeight == 2{
                    name = "22"
                }else if block.iSpaceHeight == 3{
                    name = "333"
                }else if block.iSpaceHeight == 4{
                    name = "4444"
                }
                
                block.physicsBody?.node?.name = name
                block.physicsBody?.categoryBitMask = TD_Block1Category
                block.physicsBody?.collisionBitMask = 0
                block.physicsBody?.density = 0.5
                
                block.physicsBody?.affectedByGravity = false
                block.physicsBody?.allowsRotation = false;
                block.physicsBody?.contactTestBitMask = TD_Block1Category
                block.zPosition = 1
                block.physicsBody?.restitution = 0.75
            }
        }
    }
    func gameOver(){
        isStartGame = false
//        UIAlertController.showAlert(message: "游戏结束!")
        print("游戏结束")
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
//        NSLog("didEnd")
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        if isStartGame {

            if contact.bodyA.contactTestBitMask == TD_SeaCategory{//掉到海里面
                gameOver()
                return
            }
            
            if protagonistSprite.physicsBody?.velocity.dy != 0{
                
                let nodeA = contact.bodyA.node
                let nodeB = contact.bodyB.node
                let nodeAx = (nodeA?.position.x)!
                let nodeAy = (nodeA?.position.y)!
                let nodeBx = (nodeB?.position.x)!
                var nodeBy = (nodeB?.position.y)!
                
                
                let name =  contact.bodyB.node?.name
                var iH = 0
                if name != nil{
                    iH = (name?.characters.count)!
                    nodeBy = nodeBy + CGFloat(iH) * CGFloat(TD_BlockH * 6) + 30
                }
                
                if nodeBy - nodeAy > 24{//向上碰到砖块
                    NSLog("向上碰撞")
                    let impulse = CGVector(dx: 0, dy: 0)//设置一个速度
                    protagonistSprite.physicsBody?.velocity = impulse
                    let spaceView = spaceViewArr[iH]
                    spaceView.impact(blockPosition: (nodeB?.position)!)
                }else if nodeAy - nodeBy > 24{//向下碰到砖块
                    NSLog("落到地面")
                    let impulse =  CGVector(dx: 0, dy: 0)//设置一个速度
                    protagonistSprite.physicsBody?.velocity = impulse
                    protagonistSprite.physicsBody?.affectedByGravity = false
                    protagonistSprite.isLeap = false//将主角的跳跃状态置换为未跳跃
                    
                    if iH >= 2{
                        newSpaceView()
                        for spaceView in spaceViewArr{
                            spaceView.moveDown()
                        }
                        spaceViewArr.removeFirst()
                        setSpaceViewBody()
                        protagonistSprite.moveDown()
                    }
                }else if nodeAx - nodeBx >= 18{//向左运行时碰到砖块
                    NSLog("禁止向左")
                    protagonistSprite.iBanDirection = 1
                }else if nodeBx - nodeAx >= 18{//向右运行时碰到砖块
                    NSLog("禁止向右")
                    protagonistSprite.iBanDirection = 2
                }
                
//                if (protagonistSprite.physicsBody?.velocity.dy)! > CGFloat(0){
//
//
//                    if  nodeBy > (contact.bodyA.node?.position.y)! + 20{//跳跃时头部碰撞到物体,
//                        let impulse = CGVector(dx: 0, dy: 0)//设置一个速度
//                        protagonistSprite.physicsBody?.velocity = impulse
//                        let spaceView = spaceViewArr[iH]
//                        spaceView.impact(blockPosition: (nodeB?.position)!)
//                    }else{//相差20以内认为是碰到的是平行的
//                        NSLog("")
//                    }
//                }else{
//
//                    if  (contact.bodyA.node?.position.y)! > nodeBy + 20{//降落在物体上面
//                        let impulse =  CGVector(dx: 0, dy: 0)//设置一个速度
//                        protagonistSprite.physicsBody?.velocity = impulse
//                        protagonistSprite.physicsBody?.affectedByGravity = false
//                        protagonistSprite.isLeap = false//将主角的跳跃状态置换为未跳跃
//
//                        if iH >= 2{
//                            newSpaceView()
//                            for spaceView in spaceViewArr{
//                                spaceView.moveDown()
//                            }
//                            spaceViewArr.removeFirst()
//                            setSpaceViewBody()
//                            protagonistSprite.moveDown()
//                        }
//                    }
//                }
            }
        }
    }

    func update(_ currentTime: TimeInterval,for scene: SKScene){
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
        let point = touch.location(in:self)
        let node = self.atPoint(point)
        if node.name == "stopStartLab" {
            if stopStartLab.text == "暂停"{
                stopStartLab.text = "开始"
                protagonistSprite.physicsBody?.affectedByGravity = false
            }else{
                isStartGame = true
                protagonistSprite.physicsBody?.affectedByGravity = true
                stopStartLab.text = "暂停"
            }
        }else if node.name == "leftLab"{
            protagonistSprite.setDirection(direction: 1)
        }else if node.name == "rightLab"{
            protagonistSprite.setDirection(direction: 2)
        }else if node.name == "leapLab"{
            NSLog("leapLab")
            if !protagonistSprite.isLeap{
                let impulse =  CGVector(dx: 0, dy: 3.7)//跳跃
                protagonistSprite.physicsBody?.applyImpulse(impulse)
                protagonistSprite.physicsBody?.affectedByGravity = true
                protagonistSprite.isLeap = true
            
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
        let point = touch.location(in:self)
        let node = self.atPoint(point)
        if node.name == "leftLab"{
            protagonistSprite.setDirection(direction: 0)
        }else if node.name == "rightLab"{
            protagonistSprite.setDirection(direction: 0)
        }
    }
}
