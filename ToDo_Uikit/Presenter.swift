//
//  Presenter.swift
//  ToDoList1_Uikit
//
//  Created by Mahdia Amriou on 14/02/2024.
//

import Foundation

class Presenter {
    let presenterProtocol: PresenterProtocol?
    let service = TaskService()
    
    init(presenterProtocol: PresenterProtocol?) {
        self.presenterProtocol = presenterProtocol
    }
    
    func getTasks() {
        service.getRecords { tasks, error in
            guard let tasks = tasks else {
                return
            }
            self.presenterProtocol?.getAllTask(tasks: tasks)
        }
    }
    
    func deleteTask(taskID: String, completion: @escaping (Error?) -> Void) { // Add completion handler
        service.deleteRecords(recordID: taskID) { error in
            completion(error) // Call completion handler
        }
    }
}

protocol PresenterProtocol {
    func getAllTask(tasks: [RecordTask])
    func taskDeletionCompleted(with error: Error?) // delete 
}
