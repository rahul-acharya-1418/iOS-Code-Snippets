//
//  TheBasicsViewController.swift
//  The-Swift-Programming-Language
//
//  Created by Rahul Acharya on 29/10/26.
//

import UIKit

class TheBasicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TheBasics"
        /// `In Progress`: https://docs.swift.org/latest/documentation/the-swift-programming-language/thebasics/#Comments
    }
}

extension TheBasicsViewController {
    
    /// This code can be read as:
    /// Declare a new constant called maximumNumberOfLoginAttempts, and give it a value of 10. Then, declare a new variable called currentLoginAttempt, and give it an initial value of 0.
    func declaringConstantsAndVariables1() {
        let maximumNumberOfLoginAttempts: Int = 10
        var currentLoginAttempts: Int = 0
        
    }
    
    /// the maximum number of login attempts is constant, and its value depends on the environment. In the development environment, it has a value of 100; in any other environment, its value is 10. Both branches of the if statement initialize maximumNumberOfLoginAttempts with some value, guaranteeing that the constant always gets a value.
    func declaringConstantsAndVariables2() {
        let maximumNumberOfLoginAttempts: Int
        var environment = "development"
        
        if environment == "development" {
            maximumNumberOfLoginAttempts = 100
        } else {
            maximumNumberOfLoginAttempts = 10
        }
        // Now maximumNumberOfLoginAttempts has a value, and can be read.

        // You can declare multiple constants or multiple variables on a single line, separated by commas:
        
        var x = 0.0, y = 0.0, z = 0.0
    }
    
    func declaringConstantsAndVariables3() {
        /// Variable, Constant, Static
        var str = "Hello World"
        var x = 4
        var y = 1
        let z = 3
    }
}

// MARK: - Type-Annotations
extension TheBasicsViewController {
    func typeAnnotations() {
        /// This example provides a type annotation for a variable called welcomeMessage, to indicate that the variable can store String values:
        /// “Declare a variable called welcomeMessage that’s of type String.”
        var welcomeMessage: String
        
        welcomeMessage = "Hello"
        
        /// You can define multiple related variables of the same type on a single line, separated by commas, with a single type annotation after the final variable name:
        var red, green, blue: Double
    }
}
// MARK: - Naming-Constants-and-Variables
extension TheBasicsViewController {
    /// Constant and variable names can contain almost any character, including Unicode characters:
    func namingConstantsAndVariables() {
        let π = 3.14159
        let 你好 = "你好世界"
        let 🐶🐮 = "dogcow"
    }
}

// MARK: - Printing-Constants-and-Variables
extension TheBasicsViewController {
    func printingConstantsAndVariables() {
        /// 1. normal print
        print("test 1")
        
        /// 2. uses string interpolation
        print("test another \(1+1)")
        
        /// 3. Multiple values
        print("iOS", "Swift", "Xcode")
        print("iOS", "Swift", "Xcode", separator: "-")
        
        /// 4. Custom terminator
        print("Hello", terminator: " ")
        print("World")
        print("1", terminator: "\n")
        print("2")
        print("A", terminator: "\t")
        print("B")

    }
}
