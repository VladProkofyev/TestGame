//
//  Enemy.swift
//  TestGame
//
//  Created by Прокофьев Владислав on 18.02.2022.
//

import SpriteKit

class Enemy: SKSpriteNode {
    func setupEnemy(position: CGPoint) {
        self.size = CGSize(width: 100, height: 100)
        self.texture = SKTexture(imageNamed: "enemy")
        self.position = position
        self.name = "Enemy"
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody!.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Enemy
        self.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Bullet
        self.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Enemy
        self.zRotation = .pi
    }
}
