//
//  SceneKitMap.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 30.11.2020.
//

import Foundation
import NMAKit
import SceneKit

extension SceneMapsController {
    
  func setupSceneView() {
        // transparent background for use as overlay
        sceneView.backgroundColor = UIColor.clear
        scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.loops = true
        sceneView.showsStatistics = false
        sceneView.isPlaying = true
        sceneRect = sceneView.bounds
        
        // camera
        cameraNode = SCNNode()
        camera = SCNCamera()
        cameraNode.camera = camera
        scene.rootNode.addChildNode(cameraNode)
        
        // lighting
        ambientLight = SCNLight()
        ambientLight.type = .ambient
        let color =   #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        ambientLight.color = color// UIColor(colorLiteralRed: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)
        
        // lighting
        omniLight = SCNLight()
        omniLight.type = .omni
        omniLightNode = SCNNode()
        omniLightNode.light = omniLight
        
        scene.rootNode.addChildNode(omniLightNode)
        
        // player node
        playerNode = SCNNode()
        let playerScene = SCNScene(named: "art.scnassets/Idle/fixIdle.scn")!
    
    
        let model = playerScene.rootNode.childNode(withName: "skin",
                                               recursively: false)!
     //   let rig_model = playerScene.rootNode.childNode(withName: "rig_model",
                                       //    recursively: false)!
    
        // scale model / rig_model
        model.scale = SCNVector3(0.2,0.2,0.2)
      //  rig_model.scale = SCNVector3(0.2,0.2,0.2)
    
        playerNode.addChildNode(model)
     //   playerNode.addChildNode(rig_model)
        
        scene.rootNode.addChildNode(playerNode)
        
        // corona node
        coronas.append(addTokens(NMAGeoCoordinates(latitude: 55.892882956952704, longitude: 37.54391640563343),id : 0))
        coronas.append(addTokens(NMAGeoCoordinates(latitude: 55.89176982388743, longitude: 37.54422555312789),id : 1))
        coronas.append(addTokens(NMAGeoCoordinates(latitude: 55.892265975352416, longitude: 37.544225517421054),id : 2))
        coronas.append(addTokens(NMAGeoCoordinates(latitude: 55.89227537500546, longitude: 37.54463736214839),id : 3))
        for virus in coronas {
            scene.rootNode.addChildNode(virus)
        }
    }
    func addTokens(_ geo : NMAGeoCoordinates,id : Int) -> SCNNode {
        
        let coronasScene = SCNScene(named: "art.scnassets/uszd/Coronavirus.usdz")!
        coronasNode = coronasScene.rootNode.childNodes.first!
        coronasNode.scale = SCNVector3(0.2, 0.2, 0.2)

        coronasNode.name = "present \(id)"
        coronasNode.setValue(CLLocationCoordinate2DMake(geo.latitude, geo.longitude), forKey: "coordinate")
        
        let rotate = SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 0.5)
        let moveSequence = SCNAction.sequence([rotate])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        coronasNode.runAction(moveLoop)
        coronasNode.setValue(false, forKey: "tapped")
        return coronasNode
    }
    
    func addAnimations(_ node :  SCNNode!) {
        let rotate = SCNAction.rotateBy(x: 0, y: 0, z: 3, duration: 0.5)
        let moveSequence = SCNAction.sequence([rotate])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        node.runAction(moveLoop)
    }
    
    // convert geographic coordinates to screen coordinates in the map view
       func coordinateToOverlayPosition(coordinate: CLLocationCoordinate2D) -> SCNVector3 {
            let p: CGPoint = viewMap.point(from: NMAGeoCoordinates(latitude: coordinate.latitude, longitude: coordinate.longitude))
            return SCNVector3Make(Float(p.x), Float(sceneRect.size.height - p.y), 0)
       }
    
       func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            // get pitch of map
            let mapPitchRads = Float(viewMap.tilt) * (Float.pi / 180.0)
            print("current tilt :\(viewMap.tilt)")
            // update player
            let playerPoint = coordinateToOverlayPosition(coordinate: tempPositin)
            print("user: \(tempPositin)")
            let scaleMat = SCNMatrix4MakeScale(4.0, 4.0, 4.0)
            playerNode.transform = SCNMatrix4Mult(scaleMat,
                                                SCNMatrix4Mult(SCNMatrix4MakeRotation(-mapPitchRads, 1, 0, 0),
                                                               SCNMatrix4MakeTranslation(playerPoint.x, playerPoint.y, 0)))
          // update office
          for coronasPoint in coronas {
                let coronasPos = coordinateToOverlayPosition(coordinate: coronasPoint.value(forKey: "coordinate") as! CLLocationCoordinate2D)
                coronasPoint.position = SCNVector3Make(coronasPos.x, coronasPos.y,0)
          }
          // update light position
          omniLightNode.position = SCNVector3Make(playerPoint.x, playerPoint.y + 30, 20) // magic number alert!
          
          // update camera
        let metersPerPointFirst = 0.3348600676537076//viewMap.geoCenter.distance(to: viewMap.geoCenter)///metersPerPoint(atZoomLevel: Float(viewMap.zoomLevel))
        print("meters point\(metersPerPointFirst)")
        print("level ground from Minimum \(viewMap.maximumZoomLevel.advanced(by: viewMap.zoomLevel))")
        print("level ground from Maximum \(viewMap.minimumZoomLevel.advanced(by: viewMap.zoomLevel))")

        let t1 = viewMap.maximumZoomLevel.advanced(by: viewMap.zoomLevel)
        let t2 = viewMap.minimumZoomLevel.advanced(by: viewMap.zoomLevel)
        
        let f1 = viewMap.zoomLevel.distance(to: 20)//metersPerPoint(atZoomLevel: viewMap.zoomLevel)*t2
        let f2 = viewMap.metersPerPoint(atZoomLevel: viewMap.minimumZoomLevel)*t2
        let f3 = viewMap.metersPerPoint(atZoomLevel: 0).distance(to: 20)
        
        print("f1 : \(f1)")
        print("f2 : \(f2)")
        print("f3 : \(f3)")
        print("altitude : \(viewMap.geoCenter.altitude)")
        print("current zoom level \(viewMap.zoomLevel)")
        
        let altitudePoints = 853.7030533228752///*viewMap.geoCenter.altitude*/ viewMap.geoCenter.altitude / Float(metersPerPointFirst) as Float
          let projMat = GLKMatrix4MakeOrtho(0, Float(sceneRect.size.width),  // left, right
              0, Float(sceneRect.size.height), // bottom, top
              1, Float(altitudePoints+100))               // zNear, zFar
          cameraNode.position = SCNVector3Make(0, 0, Float(800))
          cameraNode.camera!.projectionTransform = SCNMatrix4FromGLKMatrix4(projMat)
      //  if selectPresent != "" {
        //    let tokenNode = tokens.filter({$0.name == selectPresent})
         //   tokenNode[0].removeAllActions()
         //   tokenNode[0].removeFromParentNode()
       // }
      }
      
}
