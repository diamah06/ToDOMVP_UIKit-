//
//  DataManager.swift
//  ToDoList1_Uikit
//
//  Created by Mahdia Amriou on 14/02/2024.
//

import Foundation

class TaskService {
    private let url = URL(string: "https://api.airtable.com/v0/appuHqR4Gb283bZ3o/To%20do")
    private let token = "patAHCmKUJv1EhYdY.f69349ff16e42d1d24552c9088592b4e6aff3a70f61ef9d1ba57b7cff83e8b4e"
    
    func getRecords(completion: @escaping ([RecordTask]?, Error?) -> Void) {
        guard let url = url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Ici on est asynchrone
            guard error == nil, let data = data else {
                completion(nil, error)
                return
            }
            
            guard let responseHttp = response as? HTTPURLResponse else {
                completion(nil, nil)
                return
            }
            
            guard responseHttp.statusCode == 200 else {
                completion(nil, nil)
                return
            }
            
            let result: Record? = try? JSONDecoder().decode(Record.self, from: data)
            completion(result?.records, nil)
        }
        task.resume()
    }
    
    // delete 
    
    func deleteRecords(recordID: String, completion: @escaping (Error?) -> Void) {
        guard let url = url else { return }
        
        let recordURL = url.appendingPathComponent(recordID)
        
        var request = URLRequest(url: recordURL)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let responseHttp = response as? HTTPURLResponse else {
                completion(nil)
                return
            }
            
            guard responseHttp.statusCode == 200 else {
                completion(nil)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }


}
