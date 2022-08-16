import ARKit
import SceneKit

@objc(NounsGlassesViewController)
class NounsGlassesViewController: UIViewController {
  
  @IBOutlet private var arView: ARSCNView!
  
  var contentNode: SCNNode?
      
  private lazy var eyeLeftNode = contentNode!.childNode(withName: "eyeLeft", recursively: true)!
  private lazy var eyeRightNode = contentNode!.childNode(withName: "eyeRight", recursively: true)!
  private lazy var leftGlass = contentNode!.childNode(withName: "leftGlass", recursively: true)!
  private lazy var rightGlass = contentNode!.childNode(withName: "rightGlass", recursively: true)!
  private lazy var eyeRBG = contentNode!.childNode(withName: "eyeRBG", recursively: true)!
  private lazy var eyeFullBlack = contentNode!.childNode(withName: "eyeFullBlack", recursively: true)!
  private lazy var eyeRightMaterial = contentNode!.childNode(withName: "eyeRightMaterial", recursively: true)!
  private lazy var eyeLeftMaterial = contentNode!.childNode(withName: "eyeLeftMaterial", recursively: true)!
  private lazy var bridgeNode = contentNode!.childNode(withName: "bridge", recursively: true)!
  private lazy var templeTipLeftNode = contentNode!.childNode(withName: "templeTipLeft", recursively: true)!
  private lazy var templeTipRightNode = contentNode!.childNode(withName: "templeTipRight", recursively: true)!
  private lazy var templeLeftNode = contentNode!.childNode(withName: "templeLeft", recursively: true)!
  private lazy var templeRightNode = contentNode!.childNode(withName: "templeRight", recursively: true)!
  private lazy var leftFrameTopNode = contentNode!.childNode(withName: "leftFrameTop", recursively: true)!
  private lazy var leftFrameLeftNode = contentNode!.childNode(withName: "leftFrameLeft", recursively: true)!
  private lazy var leftFrameRightNode = contentNode!.childNode(withName: "leftFrameRight", recursively: true)!
  private lazy var leftFrameBottomNode = contentNode!.childNode(withName: "leftFrameBottom", recursively: true)!
  private lazy var rightFrameTopNode = contentNode!.childNode(withName: "rightFrameTop", recursively: true)!
  private lazy var rightFrameRightNode = contentNode!.childNode(withName: "rightFrameRight", recursively: true)!
  private lazy var rightFrameBottomNode = contentNode!.childNode(withName: "rightFrameBottom", recursively: true)!
  private lazy var rightFrameLeftNode = contentNode!.childNode(withName: "rightFrameLeft", recursively: true)!
  
  private var selectedGlasses = Glasses.allCases.randomElement()!
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    arView.delegate = self
    arView.session.delegate = self
    arView.automaticallyUpdatesLighting = true
    
    contentNode = SCNReferenceNode(named: "nouns-glasses")
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    arView.addGestureRecognizer(tap)
    arView.isUserInteractionEnabled = true
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    // Randomise
    selectedGlasses = Glasses.allCases.randomElement()!
    handleEyes()
    handleFrame()
  }
  
  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      UIApplication.shared.isIdleTimerDisabled = true
      
      handleSession()
  }
  
  func handleSession() {
      guard ARFaceTrackingConfiguration.isSupported else { return }
    
      let configuration = ARFaceTrackingConfiguration()
    
      if #available(iOS 13.0, *) {
          configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
      }
      configuration.isLightEstimationEnabled = true
      arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }

}

extension NounsGlassesViewController: ARSessionDelegate {
  func session(_ session: ARSession, didFailWithError error: Error) {
      guard error is ARError else { return }
      
      let errorWithInfo = error as NSError
      let messages = [
          errorWithInfo.localizedDescription,
          errorWithInfo.localizedFailureReason,
          errorWithInfo.localizedRecoverySuggestion
      ]
      let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
      
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "The AR session failed", message: errorMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { _ in }
        alert.addAction(dismissAction)
        DispatchQueue.main.async {
          self.present(alert, animated: true, completion: nil)
        }
      }
  }
}

extension NounsGlassesViewController: ARSCNViewDelegate {
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
      guard let _ = anchor as? ARFaceAnchor else { return }
      
      DispatchQueue.main.async {
        if node.childNodes.isEmpty {
          node.addChildNode(self.contentNode!)
        }
      }
    
    handleEyes()
    handleFrame()
  }
  
  private func resetEyes() {
    eyeRBG.isHidden = true
    eyeFullBlack.isHidden = true
    eyeLeftNode.isHidden = true
    eyeRightNode.isHidden = true
    leftGlass.colourMaterial(UIColor.white)
    rightGlass.colourMaterial(UIColor.white)
    eyeRightMaterial.colourMaterial(UIColor.black)
    eyeLeftMaterial.colourMaterial(UIColor.black)
  }
  
  private func handleEyes() {
    resetEyes()
        
    switch selectedGlasses {
    case .blackEyesRed:
      eyeLeftNode.isHidden = false
      eyeRightNode.isHidden = false
      eyeRightMaterial.colourMaterial(UIColor(hex: PartColour.redEye.rawValue))
      eyeLeftMaterial.colourMaterial(UIColor(hex: PartColour.redEye.rawValue))
    case .blackRGB:
      eyeRBG.isHidden = false
    case .fullblack:
      eyeFullBlack.isHidden = false
      leftGlass.colourMaterial(UIColor.black)
      rightGlass.colourMaterial(UIColor.black)
    default:
      eyeLeftNode.isHidden = false
      eyeRightNode.isHidden = false
      eyeRightMaterial.colourMaterial(UIColor(hex: PartColour.black.rawValue))
    }
  }
  
  private func handleFrame() {
    switch selectedGlasses {
    case .hipRose:
      colourWholeFrame(UIColor(hex: PartColour.pink.rawValue))
    case .honey:
      colourWholeFrame(UIColor(hex: PartColour.honey.rawValue))
    case .blackEyesRed:
      colourWholeFrame(UIColor(hex: PartColour.black.rawValue))
    case .blackRGB:
      colourWholeFrame(UIColor(hex: PartColour.black.rawValue))
    case .black:
      colourWholeFrame(UIColor(hex: PartColour.black.rawValue))
    case .blueMedSaturated:
      colourWholeFrame(UIColor(hex: PartColour.blueSaturated.rawValue))
    case .blue:
      colourWholeFrame(UIColor(hex: PartColour.blue.rawValue))
    case .frogGreen:
      colourWholeFrame(UIColor(hex: PartColour.frogGreen.rawValue))
    case .fullblack:
      colourWholeFrame(UIColor(hex: PartColour.black.rawValue))
    case .greenBlueMulti:
      bridgeNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().bridge.rawValue))
      templeTipLeftNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().templeTip.rawValue))
      templeTipRightNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().templeTip.rawValue))
      templeLeftNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().temple.rawValue))
      templeRightNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().temple.rawValue))
      leftFrameTopNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().leftFrame.rawValue))
      leftFrameRightNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().leftFrame.rawValue))
      leftFrameBottomNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().leftFrame.rawValue))
      leftFrameLeftNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().leftFrame.rawValue))
      rightFrameTopNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().rightFrame.rawValue))
      rightFrameRightNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().rightFrame.rawValue))
      rightFrameBottomNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().rightFrame.rawValue))
      rightFrameLeftNode.colourMaterial(UIColor(hex: Glasses.greenBlueMulti.colourScheme().rightFrame.rawValue))
    case .greyLight:
      colourWholeFrame(UIColor(hex: PartColour.greyLight.rawValue))
    case .guava:
      colourWholeFrame(UIColor(hex: PartColour.guavaWatermelon.rawValue))
    case .magenta:
      colourWholeFrame(UIColor(hex: PartColour.magenta.rawValue))
    case .orange:
      colourWholeFrame(UIColor(hex: PartColour.orange.rawValue))
    case .pinkPurpleMulti:
      bridgeNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().bridge.rawValue))
      templeTipLeftNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().templeTip.rawValue))
      templeTipRightNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().templeTip.rawValue))
      templeLeftNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().temple.rawValue))
      templeRightNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().temple.rawValue))
      leftFrameTopNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().leftFrame.rawValue))
      leftFrameRightNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().leftFrame.rawValue))
      leftFrameBottomNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().leftFrame.rawValue))
      leftFrameLeftNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().leftFrame.rawValue))
      rightFrameTopNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().rightFrame.rawValue))
      rightFrameRightNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().rightFrame.rawValue))
      rightFrameBottomNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().rightFrame.rawValue))
      rightFrameLeftNode.colourMaterial(UIColor(hex: Glasses.pinkPurpleMulti.colourScheme().rightFrame.rawValue))
    case .red:
      colourWholeFrame(UIColor(hex: PartColour.black.rawValue))
    case .smoke:
      colourWholeFrame(UIColor(hex: PartColour.smoke.rawValue))
    case .teal:
      colourWholeFrame(UIColor(hex: PartColour.teal.rawValue))
    case .watermelon:
      colourWholeFrame(UIColor(hex: PartColour.guavaWatermelon.rawValue))
    case .yellowOrangeMulti:
      bridgeNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().bridge.rawValue))
      templeTipLeftNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().templeTip.rawValue))
      templeTipRightNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().templeTip.rawValue))
      templeLeftNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().temple.rawValue))
      templeRightNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().temple.rawValue))
      leftFrameTopNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().leftFrame.rawValue))
      leftFrameRightNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().leftFrame.rawValue))
      leftFrameBottomNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().leftFrame.rawValue))
      leftFrameLeftNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().leftFrame.rawValue))
      rightFrameTopNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().rightFrame.rawValue))
      rightFrameRightNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().rightFrame.rawValue))
      rightFrameBottomNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().rightFrame.rawValue))
      rightFrameLeftNode.colourMaterial(UIColor(hex: Glasses.yellowOrangeMulti.colourScheme().rightFrame.rawValue))
    case .yellowSaturated:
      colourWholeFrame(UIColor(hex: PartColour.yellowSaturated.rawValue))
      }
  }
  
  private func colourWholeFrame(_ colour: UIColor?) {
    bridgeNode.colourMaterial(colour)
    templeTipLeftNode.colourMaterial(colour)
    templeTipRightNode.colourMaterial(colour)
    templeLeftNode.colourMaterial(colour)
    templeRightNode.colourMaterial(colour)
    leftFrameTopNode.colourMaterial(colour)
    leftFrameRightNode.colourMaterial(colour)
    leftFrameBottomNode.colourMaterial(colour)
    leftFrameLeftNode.colourMaterial(colour)
    rightFrameTopNode.colourMaterial(colour)
    rightFrameRightNode.colourMaterial(colour)
    rightFrameBottomNode.colourMaterial(colour)
    rightFrameLeftNode.colourMaterial(colour)
  }
    
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    guard let faceAnchor = anchor as? ARFaceAnchor else { return }
    
    let blendShapes = faceAnchor.blendShapes
    guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
        let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float
        else { return }
            
    // Blinking (they are the opposite eye from apple something something mirror)
    eyeRightNode.scale.y = 1 - eyeBlinkLeft
    eyeLeftNode.scale.y = 1 - eyeBlinkRight
     
    // Eye position
    eyeLeftNode.position.x = faceAnchor.lookAtPoint.x > 0 ? -0.0239 : -0.0403
    eyeRightNode.position.x = faceAnchor.lookAtPoint.x > 0 ? 0.0403 : 0.0239
  }
}

extension SCNNode {
  func colourMaterial(_ colour: UIColor?) {
    self.geometry?.firstMaterial?.diffuse.contents = colour
  }
}

extension SCNReferenceNode {
    convenience init(named resourceName: String) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "scn")!
        self.init(url: url)!
        self.load()
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                
                var color: UInt64 = 0
                scanner.scanHexInt64(&color)
                let mask = 0x000000FF
                let r = Int(color >> 16) & mask
                let g = Int(color >> 8) & mask
                let b = Int(color) & mask

                self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue:  CGFloat(b) / 255.0, alpha: 1)
                return
            }
        }
        return nil
    }
}
