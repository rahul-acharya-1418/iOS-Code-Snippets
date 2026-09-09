//
//  NextViewController.swift
//  LifeCyclesDemo
//
//  Created by Rahul Acharya on 09/09/26.
//

import UIKit

class NextViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("NextViewController: ",#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("NextViewController: ",#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("NextViewController: ",#function)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("NextViewController: ",#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("NextViewController: ",#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("NextViewController: ",#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("NextViewController: ",#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("NextViewController: ",#function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("NextViewController: ",#function)
    }
    
    deinit {
        print("NextViewController: ",#function)
    }
}
