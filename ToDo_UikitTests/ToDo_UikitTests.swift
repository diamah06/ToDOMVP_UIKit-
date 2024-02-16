//
//  ToDo_UikitTests.swift
//  ToDo_UikitTests
//
//  Created by Mahdia Amriou on 16/02/2024.
//

import XCTest
@testable import ToDo_Uikit

class PresenterTests: XCTestCase {
    var presenter: Presenter!
    var mockPresenterProtocol: MockPresenterProtocol!
    var mockService: MockTaskService!

    override func setUp() {
        super.setUp()
        mockPresenterProtocol = MockPresenterProtocol()
        mockService = MockTaskService()
        presenter = Presenter(presenterProtocol: mockPresenterProtocol)
        presenter.service = mockService
    }

    override func tearDown() {
        presenter = nil
        mockPresenterProtocol = nil
        mockService = nil
        super.tearDown()
    }

    func testDeleteTask() {
        // Given
        let taskID = "123"
        var receivedError: Error?

       
        let expectation = XCTestExpectation(description: "Delete task completion")

        // When
        presenter.deleteTask(taskID: taskID) { error in
            receivedError = error
            
            expectation.fulfill()
        }

        // Attendre que l'attente soit remplie
        wait(for: [expectation], timeout: 5)

        // Then
        XCTAssertEqual(mockService.mockDeleteRecordsCallsCount, 1)
        XCTAssertEqual(mockService.receivedRecordID, taskID)

        // 
        XCTAssertNil(receivedError, "Expected no error, but received \(String(describing: receivedError))")
    }
}

// Mocking the PresenterProtocol for testing purposes
class MockPresenterProtocol: PresenterProtocol {
    var getAllTaskCallsCount = 0
    var receivedTasks: [RecordTask] = []

    func getAllTask(tasks: [RecordTask]) {
        getAllTaskCallsCount += 1
        receivedTasks = tasks
    }

    func taskDeletionCompleted(with error: Error?) {
        // No need to implement for testing purposes
    }
}

// Mocking the TaskService for testing purposes
class MockTaskService: TaskService {
    var mockDeleteRecordsCallsCount = 0
    var receivedRecordID: String?

    override func getRecords(completion: @escaping ([RecordTask]?, Error?) -> Void) {
        completion([], nil)
    }

    override func deleteRecords(recordID: String, completion: @escaping (Error?) -> Void) {
        mockDeleteRecordsCallsCount += 1
        receivedRecordID = recordID
        completion(nil)
    }
}
