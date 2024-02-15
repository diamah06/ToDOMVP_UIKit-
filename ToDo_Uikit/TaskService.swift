//
//  DataManager.swift
//  ToDoList1_Uikit
//
//  Created by Mahdia Amriou on 14/02/2024.
//

import Foundation

class TaskService {
    private let url = URL(string: "https://api.airtable.com/v0/appvpzS8KBJH4XMpi/To%20do")
    private let token = "patf96PhvPfwILjBr.d3c2fff3f7bc8d5511a0e8fc8da7c1dd1fec6e79465f757076700b71c6fc4b9a"
    
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
}
