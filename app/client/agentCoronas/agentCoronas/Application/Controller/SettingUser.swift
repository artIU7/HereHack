//
//  ViewController.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 25.11.2020.
//

import UIKit
import SceneKit
class SettingUser: UIViewController {
    // SceneKit scene
    @IBOutlet weak var scene: SCNView!
    var sceneNode: SCNScene!
          var cameraNode: SCNNode!
          var camera: SCNCamera!
          var playerNode: SCNNode!
          var officeNode: SCNNode!
          var tokens = [SCNNode]()
          var ambientLightNode: SCNNode!
          var ambientLight: SCNLight!
          var omniLightNode: SCNNode!
          var omniLight: SCNLight!
          var sceneRect: CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSceneView()
        self.initializeHideKeyboard()
        // Do any additional setup after loading the view.
    }
}


 extension SettingUser {
    func initializeHideKeyboard()  {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                             action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
 }

