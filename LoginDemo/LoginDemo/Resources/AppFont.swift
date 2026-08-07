//
//  AppFont.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import Foundation

import UIKit

@frozen
public enum AppFont: String {
    case bold = "PlusJakartaSans-Bold"
    case boldItalic = "PlusJakartaSans-BoldItalic"
    case extraBold = "PlusJakartaSans-ExtraBold"
    case extraBoldItalic = "PlusJakartaSans-ExtraBoldItalic"
    case extraLight = "PlusJakartaSans-ExtraLight"
    case extraLightItalic = "PlusJakartaSans-ExtraLightItalic"
    case italic = "PlusJakartaSans-Italic"
    case light = "PlusJakartaSans-Light"
    case lightItalic = "PlusJakartaSans-LightItalic"
    case medium = "PlusJakartaSans-Medium"
    case mediumItalic = "PlusJakartaSans-MediumItalic"
    case regular = "PlusJakartaSans-Regular"
    case semiBold = "PlusJakartaSans-SemiBold"
    case semiBoldItalic = "PlusJakartaSans-SemiBoldItalic"
    
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UILabel {
    func font(_ style: AppFont, _ size: CGFloat) {
        self.font = style.font(size: size)
    }
}

