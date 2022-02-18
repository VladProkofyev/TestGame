//
//  GameScene.swift
//  TestGame
//
//  Created by Прокофьев Владислав on 18.02.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var stars = [SKSpriteNode]()
    let ship = Ship()
    let enemy = Enemy()
    let gameOverLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    var score = 0
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        self.setupBackground()
        self.addChild(ship)
        self.ship.setupShip(position: CGPoint(x: 0, y: -self.size.height / 3))
        self.addChild(enemy)
        self.enemy.setupEnemy(position: CGPoint(x: 0, y: self.size.height / 1.5))
        self.setupEnemy()
        self.setupGameOver()
        self.addChild(self.scoreLabel)
        self.setupScore(score: 0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.enemy.position.y < -350 {
            self.enemy.removeAllActions()
            self.ship.bullet.removeAllActions()
            self.gameOverLabel.isHidden = false
        }
    }
}
// MARK: Contacts
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        self.ship.bullet.removeAllActions()
        self.enemy.removeAllActions()
        let random = CGFloat.random(in: -self.size.width / 2...self.size.width / 2)
        self.enemy.setupEnemy(position: CGPoint(x: random, y: self.size.height / 1.5))
        self.setupEnemy()
        self.ship.bullet.setupBullet()
        self.ship.fire()
        self.score += 1
        self.setupScore(score: self.score)
    }
}
// MARK: Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.ship.position.x = self.getFingerPos(touches: touches).x
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func getNodeFromTouch(touches: Set<UITouch>) -> SKNode {
        let touch: UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        return touchedNode
    }
    
    func getFingerPos(touches: Set<UITouch>) -> CGPoint {
        let touch: UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        return positionInScene
    }
}
// MARK: UI Setups
private extension GameScene {
    func setupBackground() {
        for _ in 0...80 {
            let star = SKSpriteNode()
            star.size = CGSize(width: 2, height: 2)
            star.color = .white
            self.addChild(star)
            self.stars.append(star)
        }
        
        for star in stars {
            let xpos = CGFloat.random(in: -self.size.width / 2...self.size.width / 2)
            star.position = CGPoint(x: xpos, y: self.size.height)
            let ranomSpeed = TimeInterval.random(in: 0.2...0.5)
            let action = SKAction.moveTo(y: -self.size.height + 20, duration: ranomSpeed)
            let moveToStartPos = SKAction.moveTo(y: self.size.height, duration: 0.0)
            let sequnce = SKAction.sequence([action, moveToStartPos])
            let repeatActions = SKAction.repeatForever(sequnce)
            star.run(repeatActions)
        }
    }
    
    func setupEnemy() {
        let action = SKAction.moveTo(y: -1500, duration: 7)
        enemy.run(action)
    }
    
    func setupGameOver() {
        self.gameOverLabel.text = "Game Over"
        self.gameOverLabel.fontSize = 80
        self.gameOverLabel.fontColor = .red
        self.gameOverLabel.isHidden = true
        self.addChild(gameOverLabel)
    }
    
    func setupScore(score: Int) {
        self.scoreLabel.position = CGPoint(x: -self.size.width / 3 + 10, y: self.size.height / 3 + 40)
        self.scoreLabel.text = "Score: \(score)"
        self.scoreLabel.fontSize = 80
        self.scoreLabel.fontColor = .white
    }
}

struct CollisionCategoryBitmask {
    static let Bullet: UInt32 = 0x1 << 0
    static let Enemy: UInt32 = 0x1 << 1
}
