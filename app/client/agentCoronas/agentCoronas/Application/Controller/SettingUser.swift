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
    let mapsChild = SceneMapsController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSceneView()
        self.initializeHideKeyboard()
        // Do any additional setup after loading the view.
    }
    // IBAction open maps controller
    @IBAction func toMaps() {
        let storyboardName = "SceneMaps"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        displayContentController(content: controller)
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
extension SettingUser {
    func displayContentController(content: UIViewController) {
        addChild(content)
        self.view.addSubview(content.view)
        content.didMove(toParent: self)
    }
}

