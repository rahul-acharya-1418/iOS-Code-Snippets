//
//  StartViewController.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createButton: AppButton!
    @IBOutlet weak var signInButton: AppButton!
    @IBOutlet weak var privacyTextView: UITextView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
    }
    
    @IBAction func signInButtonTapped(_ sender: AppButton) {
        let viewController = AppStoryboard.main.instantiateViewController(ViewController.self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func createButtonTapped(_ sender: AppButton) {
        let viewController = AppStoryboard.main.instantiateViewController(ViewController.self)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - setup config
extension StartViewController {
    func setupConfig() {
        setupUI()
    }
    
    func setupUI() {
        /// title config
        titleLabel.font = AppFont.medium.font(size: 20)
        titleLabel.textColor = .pureWhite
        
        /// button config
        createButton.buttonStyle = .primary
        signInButton.buttonStyle = .plain
        
        configurePrivacyTextView()
    }
}

extension StartViewController: UITextViewDelegate {
    
    private func configurePrivacyTextView() {
        let fullText = "By signing up, you agree to our Terms & Conditions. See how we use your data in our Privacy Policy."
        let rangeOneText = "Terms & Conditions"
        let rangeTwoText = "Privacy Policy."

        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: AppFont.regular.font(size: 14),
                .foregroundColor: UIColor.pureWhite
            ]
        )

        let rangeOne = (fullText as NSString).range(of: rangeOneText)
        attributedString.addAttributes([
            .font: AppFont.bold.font(size: 14),
            .foregroundColor: UIColor.backgroundSecondary,
            .link: URL(string: "terms://")!
        ], range: rangeOne)

        let rangeTwo = (fullText as NSString).range(of: rangeTwoText)
        attributedString.addAttributes([
            .font: AppFont.bold.font(size: 14),
            .foregroundColor: UIColor.backgroundSecondary,
            .link: URL(string: "privacy://")!
        ], range: rangeTwo)

        privacyTextView.attributedText = attributedString
        privacyTextView.backgroundColor = .clear
        privacyTextView.isEditable = false
        privacyTextView.isScrollEnabled = false
        privacyTextView.textContainerInset = .zero
        privacyTextView.textContainer.lineFragmentPadding = 0
        privacyTextView.linkTextAttributes = [:]
        privacyTextView.delegate = self
        privacyTextView.textAlignment = .center
    }

    func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction? {
        switch textItem.content {
        case .link(let uRL):
            switch uRL.scheme {
            case "terms":
                print("Terms & Conditions tapped")
                // Navigate to Terms screen

            case "privacy":
                print("Privacy Policy tapped")
                // Navigate to Privacy Policy screen

            default:
                break
            }
        case .textAttachment(_):
            break
        case .tag(_):
            break
         default:
            break
        }
        return nil
    }
}
