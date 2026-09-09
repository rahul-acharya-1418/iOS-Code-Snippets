//
//  ViewController.swift
//  LifeCyclesDemo
//
//  Created by Rahul Acharya on 09/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("ViewController: ",#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController: ",#function)
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if let nextVC = storyboard.instantiateViewController(identifier: "NextViewController") as?  NextViewController {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController: ",#function)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("ViewController: ",#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ViewController: ",#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ViewController: ",#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController: ",#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController: ",#function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("ViewController: ",#function)
    }
    
    deinit {
        print("ViewController: ",#function)
    }
}
