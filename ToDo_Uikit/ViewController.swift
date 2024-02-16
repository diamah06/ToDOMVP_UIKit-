//
//  ViewController.swift
//  ToDo_Uikit
//
//  Created by Mahdia Amriou on 16/02/2024.
//

import UIKit

class ViewController: UIViewController, PresenterProtocol {
    func taskDeletionCompleted(with error: Error?) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter = Presenter(presenterProtocol: self)
    var tasks: [RecordTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter.getTasks()
        
        // Supprimer la première tâche
        if tasks.count > 0 {
            deleteTask(at: 0) // Supprime la première tâche si elle existe
        }
    }
    
    func getAllTask(tasks: [RecordTask]) {
        // Ici je mets a jour l'interface
        self.tasks = tasks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.label.text = tasks[indexPath.row].fields.task
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    // Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath.row)
        }
    }
}

extension ViewController {
    func deleteTask(at index: Int) {
        guard index < tasks.count else {
            print("Index invalide")
            return
        }
        
        let taskID = tasks[index].id
        presenter.deleteTask(taskID: taskID) { error in
            if let error = error {
                print("Erreur lors de la suppression de la tâche : \(error)")
            } else {
                // Suppression réussie
                self.tasks.remove(at: index)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}





