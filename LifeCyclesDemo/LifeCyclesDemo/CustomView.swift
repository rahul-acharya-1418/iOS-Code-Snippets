//
//  CustomView.swift
//  LifeCyclesDemo
//
//  Created by Rahul Acharya on 09/09/26.
//
import UIKit
import Foundation

class CustomView: UIView {
    
      override init(frame: CGRect) {
          super.init(frame: frame)
          print("CustomView: ",#function)
          backgroundColor = .lightGray
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          print("CustomView: ",#function)
      }
      
      override func willMove(toSuperview newSuperview: UIView?) {
          super.willMove(toSuperview: newSuperview)
          print("CustomView: ",#function)
          // Called when the view is about to be added or removed from its superview
          if newSuperview != nil {
              // View is being added to a superview
          } else {
              // View is being removed from its superview
          }
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          print("CustomView: ",#function)
          // Called when the view's bounds or constraints change
          // Perform layout-related tasks here, such as updating subview frames or constraints
      }
      
      override func draw(_ rect: CGRect) {
          super.draw(rect)
          print("CustomView: ",#function)
          // Called to draw the view's content
          // Perform custom drawing here using Core Graphics or other drawing APIs
      }
      
      override func didMoveToSuperview() {
          super.didMoveToSuperview()
          print("CustomView: ",#function)
          // Called when the view has been added or removed from its superview
          if superview != nil {
              // View has been added to a superview
          } else {
              // View has been removed from its superview
          }
      }
      
      override func didMoveToWindow() {
          super.didMoveToWindow()
          print("CustomView: ",#function)
          // Called when the view has been added or removed from a window
          if window != nil {
              // View has been added to a window
          } else {
              // View has been removed from a window
          }
      }
      
      override func removeFromSuperview() {
          // Perform cleanup tasks here
          // Remove any observers, release resources, etc.
          
          super.removeFromSuperview()
          print("CustomView: ",#function)
      }
}
