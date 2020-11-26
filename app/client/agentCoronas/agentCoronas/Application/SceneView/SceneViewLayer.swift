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
        scene.autoenablesDefaultLighting = true
        scene.delegate = self
        scene.loops = true
        scene.showsStatistics = true
        scene.isPlaying = true
         // player node
        let playerScene = SCNScene(named: "art.scnassets/Idle/fixIdle.dae")! // test load static object
        scene.scene = playerScene // add our text holder to the sce
      }
 
}
