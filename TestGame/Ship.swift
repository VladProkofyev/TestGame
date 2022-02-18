//
//  Ship.swift
//  TestGame
//
//  Created by Прокофьев Владислав on 18.02.2022.
//

import SpriteKit

class Ship: SKSpriteNode {
    let bullet = Bullet()
    func setupShip(position: CGPoint) {
        self.size = CGSize(width: 100, height: 100)
        self.texture = SKTexture(imageNamed: "ship")
        self.position = position
        self.name = "Ship"
        self.addChild(bullet)
        bullet.setupBullet()
        self.fire()
    }
    
    func fire() {
        let bulletYPos = bullet.position.y
        let action = SKAction.moveTo(y: 1500, duration: 0.3)
        let reverseAction = SKAction.moveTo(y: bulletYPos, duration: 0.0)
        let sequence = SKAction.sequence([action, reverseAction])
        let repeatActions = SKAction.repeatForever(sequence)
        self.bullet.run(repeatActions)
    }
}
