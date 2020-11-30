//
//  SceneViewLayer.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 26.11.2020.
//

import Foundation
import SceneKit
import UIKit

extension SettingUser  {

    func setupSceneView() {
          // transparent background for use as overlay
        scene.backgroundColor = UIColor.clear
        // player node
        var playerScene = SCNScene(named: "art.scnassets/Idle/fixIdle.dae")! // test load static object
        //
        let player = playerScene.rootNode.childNode(withName: "rigl",
                                                                 recursively: false)!
      
        player.scale.x = 0.1// = SCNVector3(0.2,0.2,0.2)
        player.scale.y = 0.1
        player.scale.z = 0.1
        
        playerScene = SCNScene()
        playerScene.rootNode.addChildNode(player)
        // 2: Add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: Place camera
        cameraNode.position = SCNVector3(x: 0, y: 65, z: 110)
        // 4: Set camera on scene
        playerScene.rootNode.addChildNode(cameraNode)
        // 5: Adding light to scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 65, z: 110)
        playerScene.rootNode.addChildNode(lightNode)
        // 6: Creating and adding ambien light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        playerScene.rootNode.addChildNode(ambientLightNode)
        // If you don't want to fix manually the lights
        scene.autoenablesDefaultLighting = true
        // Allow user to manipulate camera
        scene.allowsCameraControl = true
        // Show FPS logs and timming
        //scene.showsStatistics = true
        // Allow user translate image
        scene.cameraControlConfiguration.allowsTranslation = false
        // Set scene settings
        scene.scene = playerScene
        scene.loops = true
        scene.isPlaying = true
      }
}
