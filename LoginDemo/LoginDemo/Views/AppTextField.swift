//
//  AppTextField.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//

import UIKit

final class AppTextField: UITextField {

    // MARK: - Constants

    private enum Constants {
        static let horizontalPadding: CGFloat = 20
        static let eyeButtonSize: CGFloat = 44
        static let rightViewWidth: CGFloat = 54
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }

    // MARK: - Properties

    @IBInspectable var isPasswordTF: Bool = false {
        didSet { configurePasswordField() }
    }

    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(
            x: 0,
            y: 0,
            width: Constants.eyeButtonSize,
            height: Constants.eyeButtonSize
        )
        button.tintColor = .slateGray
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Configuration

    private func configure() {
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.lightSilver.cgColor
        backgroundColor = .white

        configurePasswordField()
    }

    private func configurePasswordField() {
        guard isPasswordTF else {
            isSecureTextEntry = false
            rightView = nil
            rightViewMode = .never
            return
        }

        isSecureTextEntry = true
        
        let containerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: Constants.rightViewWidth,
                height: Constants.eyeButtonSize
            )
        )

        eyeButton.frame = CGRect(
            x: 0,
            y: 0,
            width: Constants.eyeButtonSize,
            height: Constants.eyeButtonSize
        )

        containerView.addSubview(eyeButton)
        rightView = containerView
        rightViewMode = .always
    }

    @objc
    private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()

        let imageName = isSecureTextEntry ? "eye.slash" : "eye"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)

        // Prevent cursor jump
        let currentText = text
        text = nil
        text = currentText
    }
}

// MARK: - UITextField

extension AppTextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        insetRect(for: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        insetRect(for: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        insetRect(for: bounds)
    }

    private func insetRect(for bounds: CGRect) -> CGRect {
        let rightInset = isPasswordTF
            ? Constants.eyeButtonSize + Constants.horizontalPadding
            : Constants.horizontalPadding

        return bounds.inset(by: UIEdgeInsets(top: 0,
                                             left: Constants.horizontalPadding,
                                             bottom: 0,
                                             right: rightInset))
    }
}

