//
//  Model.swift
//  ToDoList1_Uikit
//
//  Created by Mahdia Amriou on 14/02/2024.
//

import Foundation

struct Record: Codable {
    let records: [RecordTask]
}

struct RecordTask: Codable {
    let id: String
    let fields: Fields
}

struct  Fields: Codable {
    let toDoBefore, priority, task: String

    enum CodingKeys: String, CodingKey {
        case task = "Task"
        case toDoBefore = "To do before"
        case priority = "Priority"
        
    }
}

