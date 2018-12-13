//
//  ViewController.swift
//  PokeCards3D
//
//  Created by Amarjit Singh on 12/12/18.
//  Copyright © 2018 Amarjit Singh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 5
            
            print("Images Successfully Added")
            
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            switch imageAnchor.referenceImage.name{
                case "pikachu-card": let pokeNode = whichPoke(cardName: "pikachu")
                                    planeNode.addChildNode(pokeNode)
                case "snorlax-card": let pokeNode = whichPoke(cardName: "snorlax")
                                    planeNode.addChildNode(pokeNode)
                case "charmander-card": let pokeNode = whichPoke(cardName: "charmander")
                                    planeNode.addChildNode(pokeNode)
                case "bulbasaur-card": let pokeNode = whichPoke(cardName: "bulbasaur")
                                    planeNode.addChildNode(pokeNode)
                case "squirtle-card": let pokeNode = whichPoke(cardName: "squirtle")
                                    planeNode.addChildNode(pokeNode)
                default: print("error")
            }
 
        }
        
        
        
        return node
        
    }
    
    func whichPoke(cardName: String) -> SCNNode{
        var pokeNode1 = SCNNode()
        if let pokeScene = SCNScene(named: "art.scnassets/\(cardName).scn") {
            if let pokeNode = pokeScene.rootNode.childNodes.first {
                pokeNode.eulerAngles.x = .pi / 2
                pokeNode1 = pokeNode
            }
        }
        return pokeNode1
    }
    
}
