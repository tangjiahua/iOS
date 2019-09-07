//
//  ViewController.swift
//  ARDemo
//
//  Created by 汤佳桦 on 2019/7/20.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView = ARSCNView()
    var detectedPlanes : [String : SCNNode] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.frame = view.bounds
        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        
        view.addSubview(sceneView)
//        let configuration = ARWorldTrackingConfiguration()
//        sceneView.session.run(configuration)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
        var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        
        tapGesture.addTarget(self, action: #selector(self.tap(_:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    @objc func tap(_ gesture: UITapGestureRecognizer) {
        if let frontVec = sceneView.pointOfView?.simdWorldFront, let position = sceneView.pointOfView?.simdPosition {
            let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.02)
            box.firstMaterial?.diffuse.contents = UIColor.gray
            let boxNode = SCNNode(geometry: box)
            boxNode.simdPosition = position + frontVec * 0.3
            sceneView.scene.rootNode.addChildNode(boxNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        guard let planeNode = detectedPlanes[anchor.identifier.uuidString] else { return }
        
        let planeShape = planeNode.geometry as! SCNPlane
        
        planeShape.width = CGFloat(planeAnchor.extent.x)
        planeShape.height = CGFloat(planeAnchor.extent.z)
        
        planeNode.position = SCNVector3Make(planeAnchor.center.x,
                                            planeAnchor.center.y,
                                            planeAnchor.center.z)
    }

}

