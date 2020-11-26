//
//  SceneViewLayer.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 26.11.2020.
//

import Foundation
import SceneKit
import UIKit

extension SettingUser : SCNSceneRendererDelegate {
  
    
    func setupSceneView() {
          // transparent background for use as overlay
        scene.backgroundColor = UIColor.clear
        sceneNode = SCNScene()
        scene.autoenablesDefaultLighting = true
        scene.scene = sceneNode
        scene.delegate = self
        scene.loops = true
        scene.showsStatistics = false
        scene.isPlaying = true
        sceneRect = scene.bounds
          
          // camera
          cameraNode = SCNNode()
          camera = SCNCamera()
          cameraNode.camera = camera
        
          
          // lighting
          ambientLight = SCNLight()
          ambientLight.type = .ambient
          let color =   #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
          ambientLight.color = color// UIColor(colorLiteralRed: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
          ambientLightNode = SCNNode()
          ambientLightNode.light = ambientLight
          sceneNode.rootNode.addChildNode(ambientLightNode)
          
          // lighting
          omniLight = SCNLight()
          omniLight.type = .omni
          omniLightNode = SCNNode()
          omniLightNode.light = omniLight
          
          sceneNode.rootNode.addChildNode(omniLightNode)
          
          // player node
          playerNode = SCNNode()
          let playerScene = SCNScene(named: "art.scnassets/Idle.dae")! // test load static object
          let playerModelNode = playerScene.rootNode.childNodes.first!
          cameraNode.position = SCNVector3(playerModelNode.position.x,playerModelNode.position.y+87.784,playerModelNode.position.z + 174.987)
          sceneNode.rootNode.addChildNode(cameraNode)

          playerNode.addChildNode(playerModelNode)
          sceneNode.rootNode.addChildNode(playerNode)
          sceneNode = playerScene
      }
 
}
