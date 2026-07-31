//
//  AppGradientView.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//


import UIKit

final class AppGradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    /// Default: Top → Bottom
    @IBInspectable var isLeftToRight: Bool = false {
        didSet {
            updateGradientDirection()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.backgroundPrimary.cgColor,
            UIColor.backgroundSecondary.cgColor
        ]
        gradientLayer.locations = [0, 1]
        updateGradientDirection()
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateGradientDirection() {
        if isLeftToRight {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }
    }
}

