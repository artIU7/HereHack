//
//  SceneMapsController.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 27.11.2020.
//

import UIKit
import NMAKit

class SceneMapsController: UIViewController {
    var colorScheme: NMACustomizableScheme?
    let colorSchemeName = "color"
    let zoom = NMAZoomRange(minimum: 0, maximum: 20)
    @IBOutlet var viewMap : NMAMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorCustomization()
        // Do any additional setup after loading the view.
    }
    
    func colorCustomization() {
      
        //create customizable scheme with specific scheme name based on NMAMapSchemeNormalDay
        if (colorScheme == nil) {
            colorScheme = viewMap.createCustomizableScheme(colorSchemeName, basedOn: NMAMapSchemeTruckNight)
        }
        
        //create customizable color for property .parkColor for specific zoom level
        let parkColor = colorScheme?.colorForProperty(NMASchemeColorProperty.parkColor, zoomLevel: 18.0)
        
        parkColor?.red = 100
        parkColor?.green = 100
        parkColor?.blue = 133
        
        //create customizable color for property .building for specific zoom level
        let buildingColor = colorScheme?.colorForProperty(NMASchemeColorProperty.buildingColor, zoomLevel: 18.0)
        
        buildingColor?.red = 120
        buildingColor?.green = 50
        buildingColor?.blue = 133
        
        //create customizable color for property .pedestrian for specific zoom level
        let pedestrianColor = colorScheme?.colorForProperty(NMASchemeColorProperty.airportAreaColor, zoomLevel: 18.0)
        
        pedestrianColor?.red = 90
        pedestrianColor?.green = 50
        pedestrianColor?.blue = 70
        
        //create customizable color for property .streetCategory3Color for specific zoom level
        let street3Color = colorScheme?.colorForProperty(NMASchemeColorProperty(rawValue: 517)!, zoomLevel: 18.0)
        let color = #colorLiteral(red: 0.2117647059, green: 0.2974572328, blue: 0.5, alpha: 1)
        street3Color?.setColor(color)
       // lakeColor?.red = 0
      //  lakeColor?.green = 150
       // lakeColor?.blue = 70
       
        //create customizable color for property .streetCategory3Color for specific zoom level
        let street3OutColor = colorScheme?.colorForProperty(NMASchemeColorProperty.streetCategory2Color, zoomLevel: 18.0)
        
        let colorOut3Line = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        street3OutColor?.setColor(colorOut3Line)
        
        //set color property
        if let color = buildingColor {
            colorScheme?.setColorProperty(color, zoomRange: zoom)
        }
        
        //set color property
        if let color = parkColor {
            colorScheme?.setColorProperty(color, zoomRange: zoom)
        }
        
        //set color property
        if let color = pedestrianColor {
            colorScheme?.setColorProperty(color, zoomRange: zoom)
        }
        
        //set color property
        if let color = street3Color {
            colorScheme?.setColorProperty(color, zoomRange: zoom)
        }
        
        //set color property
        if let color = street3OutColor {
            colorScheme?.setColorProperty(color, zoomRange: zoom)
        }
        let count = self.colorScheme?.accessibilityElementCount()
        for i in 1...638 - 1 {
            let tempColor = colorScheme?.colorForProperty(NMASchemeColorProperty(rawValue: UInt(i))!, zoomLevel: 18.0)
            if i % 10 == 0 {
                
                let color = #colorLiteral(red: 0.7712681305, green: 0.2980392157, blue: 0.5019607843, alpha: 1)
                
            tempColor?.red = 54 + i*2*10
            tempColor?.green = 76 - i*2
            tempColor?.blue = 128 - i*2*10 + 2*i
            } else  if i % 12 == 0 {
                tempColor?.red = 0 + i*2
                tempColor?.green = 10 - i*2
                tempColor?.blue = 50 - i*2 + 2*i
            } else {
                tempColor?.red = 197 + i*2
                tempColor?.green = 76 - i*2
                tempColor?.blue = 128 - i*2 + 2*i
            }
            
            colorScheme?.setColorProperty(tempColor!, zoomRange: zoom)
        }
        //set map scheme to be customized scheme
        viewMap.mapScheme = colorSchemeName
        //viewMap.set(geoCenter: <#T##NMAGeoCoordinates#>, animation: <#T##NMAMapAnimation#>)
       
       // viewMap.set(geoCenter: NMAGeoCoordinates(latitude: 55.790915, longitude: 38.438565), zoomLevel: viewMap.minimumZoomLevel, animation: NMAMapAnimation.none)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
