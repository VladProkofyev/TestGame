//
//  Bullet.swift
//  TestGame
//
//  Created by Прокофьев Владислав on 18.02.2022.
//

import SpriteKit

class Bullet: SKSpriteNode {
    func setupBullet() {
        self.size = CGSize(width: 10, height: 10)
        self.color = .magenta
        self.position = CGPoint(x: 0, y: 0)
        self.name = "Bullet"
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Bullet
        self.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Enemy
        self.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Bullet
    }
}
