//
//  AppLabel.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//


import UIKit

final class AppLabel: UILabel {
    
    var labelStyle: AppLabelStyle = .title {
        didSet {
            applyStyle()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyStyle()
    }
    
    private func applyStyle() {
        switch labelStyle {
        case .title:
            applyTitleStyle()
        case .description:
            applyDescriptionStyle()
        case .subDescription:
            applySubDescriptionStyle()
        }
        
        textColor = .charcoalBlack
    }
    
    private func applyTitleStyle() {
        font = .systemFont(ofSize: 22, weight: .semibold)
    }
    
    private func applyDescriptionStyle() {
        font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private func applySubDescriptionStyle() {
        font = .systemFont(ofSize: 14, weight: .medium)
    }
    
}

enum AppLabelStyle {
    case title
    case description
    case subDescription
}
