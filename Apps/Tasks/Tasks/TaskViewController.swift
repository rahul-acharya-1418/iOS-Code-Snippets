//
//  TaskViewController.swift
//  Tasks
//
//  Created by Rahul Acharya on 02/11/26.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var task: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Delete",
            style: .done,
            target: self,
            action: #selector(deleteTask)
        )
    }
    
    @objc func deleteTask() {
//        let newCount = count - 1
//        UserDefaults().setValue(<#T##value: Any?##Any?#>, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "task_\(currentPosition)")
    }
    
}
