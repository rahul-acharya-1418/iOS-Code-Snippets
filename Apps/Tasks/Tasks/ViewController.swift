//
//  ViewController.swift
//  Tasks
//
//  Created by Rahul Acharya on 02/11/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get all currents tasks
        title = "Task"
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(didTapAdd)
        )
        
        // Setup
        /// false
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().setValue(true, forKey: "setup")
            UserDefaults().setValue(0, forKey: "count")
        }
        // Get all current saved tasks
        updateTasks()
    }
    
    func updateTasks() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int,
        count > 0 else {
            return
        }
        
        for x in 0...count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
        
    }
    
    @objc
    func didTapAdd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        vc.title = "New Task"
        vc.update = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {            
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
