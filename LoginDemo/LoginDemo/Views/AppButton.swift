//
//  AppButton.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//


import UIKit

final class AppButton: UIButton {

    var buttonStyle: AppButtonStyle = .primary{
        didSet {
            applyStyle()
        }
    }
    
    var fullText: String = "" {
        didSet { applyStyle() }
    }

    var rangeText: String = "" {
        didSet { applyStyle() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
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
        switch buttonStyle {
        case .primary:
            applyPrimaryStyle()

        case .secondary:
            applySecondaryStyle()

        case .disabled:
            applyDisabledStyle()

        case .guest:
            applyGuestStyle()

        case .plain:
            applyPlainStyle()
        }
        clipsToBounds = true
        layer.cornerRadius = 10
    }

    /// Primary (Sign In)
    private func applyPrimaryStyle() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.white, for: .normal)
        backgroundColor = .backgroundSecondary
    }

    /// Secondary (Create Account)
    private func applySecondaryStyle() {

        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.backgroundSecondary
            ]
        )

        let range = (fullText as NSString).range(of: rangeText)

        attributedString.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 16, weight: .bold),
            range: range
        )

        setAttributedTitle(attributedString, for: .normal)

        backgroundColor = .iceBlue
    }

    /// Disabled
    private func applyDisabledStyle() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.richBlack, for: .normal)
        backgroundColor = .cloudGray
    }

    /// Guest
    private func applyGuestStyle() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        setTitleColor(.richBlack, for: .normal)
        backgroundColor = .cloudGray
    }

    /// Plain
    private func applyPlainStyle() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.pureWhite, for: .normal)
        backgroundColor = .clear
    }
}

enum AppButtonStyle {
    case primary
    case secondary
    case disabled
    case guest
    case plain
}
