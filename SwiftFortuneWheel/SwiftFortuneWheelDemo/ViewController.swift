//
//  ViewController.swift
//  SwiftFortuneWheelDemo
//
//  Created by Rahul Acharya on 03/07/26.
//

import UIKit
import SwiftFortuneWheel

class ViewController: UIViewController {
    
    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.layer.cornerRadius = centerView.bounds.width / 2
            centerView.layer.borderColor = CGColor.init(srgbRed: CGFloat(256), green: CGFloat(256), blue: CGFloat(256), alpha: 1)
            centerView.layer.borderWidth = 7
        }
    }
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .variousWheelSimpleConfiguration
            wheelControl.slices = slices
            wheelControl.pinImage = "whitePinArrow"
            
            wheelControl.pinImageViewCollisionEffect = CollisionEffect(force: 8, angle: 20)
            
            wheelControl.edgeCollisionDetectionOn = true
            wheelControl.impactFeedbackOn = true // sound on/off
        }
    }
    
    var prizes = ["$30", "$10", "$250", "$20", "LOSE", "$5", "$500", "$80", "LOSE", "$200"]
    
    lazy var slices: [Slice] = {
        let slices = prizes.map({ Slice.init(contents: [Slice.ContentType.text(text: $0, preferences: .variousWheelSimpleText)]) })
        return slices
    }()

    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerView.layer.cornerRadius = centerView.bounds.width / 2
    }
    
    @IBAction func rotateTap(_ sender: Any) {
        let winningIndex = finishIndex
        
        wheelControl.startRotationAnimation(
            finishIndex: winningIndex,
            continuousRotationTime: 1
        ) { (finished) in
            if finished {
                print("Winner index: \(winningIndex)")
                print("Prize: \(self.prizes[winningIndex])")
            }
        }
    }
}

public extension SFWConfiguration {
    static var variousWheelSimpleConfiguration: SFWConfiguration {
        
        let colors = [#colorLiteral(red: 0.9420027733, green: 0.7658308744, blue: 0.136086911, alpha: 1),
                      #colorLiteral(red: 0.9099512696, green: 0.4911828637, blue: 0.1421333849, alpha: 1),
                      #colorLiteral(red: 0.8836082816, green: 0.3054297864, blue: 0.2412178218, alpha: 1),
                      #colorLiteral(red: 0.8722914457, green: 0.1358049214, blue: 0.382327497, alpha: 1),
                      #colorLiteral(red: 0.578535378, green: 0.6434150338, blue: 0.6437515616, alpha: 1),
                      #colorLiteral(red: 0.07094667107, green: 0.6180127263, blue: 0.5455638766, alpha: 1),
                      #colorLiteral(red: 0.1627037525, green: 0.4977462888, blue: 0.7221878171, alpha: 1),
                      #colorLiteral(red: 0.5330474377, green: 0.2909428477, blue: 0.6148440838, alpha: 1),
                      #colorLiteral(red: 0.5619059801, green: 0.2522692084, blue: 0.4293728471, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1)]
        
        let pin = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 30,height: 50), position: .top, verticalOffset: -30)
        
        let sliceColorType = SFWConfiguration.ColorType.customPatternColors(colors: colors, defaultColor: .white)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 3, strokeColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 7, strokeColor: .white)
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .top)
        
        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences, pinPreferences: pin)
        
        return configuration
    }
}

public extension TextPreferences {
    static var variousWheelSimpleText: TextPreferences {
        let textPreferences = TextPreferences(textColorType: SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white),
                                              font: .systemFont(ofSize: 16, weight: .bold),
                                              verticalOffset: 12)
        return textPreferences
    }
}
