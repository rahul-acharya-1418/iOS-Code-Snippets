//
//  ViewController.swift
//  tmp
//
//  Created by Rahul Acharya on 03/07/26.
////
//
//import UIKit
//import SwiftConfettiView
//
//class ViewController: UIViewController {
//    
//    private var confettiView: SwiftConfettiView?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBAction func buttonTap(_ sender: UIButton) {
//        // Remove previous one if it exists
//        confettiView?.removeFromSuperview()
//        
//        let confetti = SwiftConfettiView(frame: view.bounds)
//        confetti.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        view.addSubview(confetti)
//        confetti.applyPreset(.perfect)
//        confetti.playSound = true
//        confetti.startConfetti()
//        confettiView = confetti
//    }
//}
//

import UIKit
import SwiftConfettiView

class ViewController: UIViewController {

    private var confettiView: SwiftConfettiView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTap(_ sender: UIButton) {

        // Stop and remove previous animation
        if let confetti = confettiView {
            confetti.stopConfetti()
            confetti.removeFromSuperview()
            confettiView = nil
        }

        // Create a new confetti view
        let confetti = SwiftConfettiView(frame: view.bounds)
        confetti.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        confetti.applyPreset(.perfect)
        confetti.playSound = true

        view.addSubview(confetti)
        view.bringSubviewToFront(confetti)

        confetti.startConfetti()

        confettiView = confetti

        // Automatically clean up after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }

            self.confettiView?.stopConfetti()
            self.confettiView?.removeFromSuperview()
            self.confettiView = nil
        }
    }
}
