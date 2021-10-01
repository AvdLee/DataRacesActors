//
//  DataRacesActorsTests.swift
//  DataRacesActorsTests
//
//  Created by Antoine van der Lee on 29/09/2021.
//

import XCTest
@testable import DataRacesActors

class DataRacesActorsTests: XCTestCase {

    func testBankTransferThreading() throws {
        let accountOne = BankAccount(accountNumber: 0, initialDeposit: 200)
        let accountTwo = BankAccount(accountNumber: 0, initialDeposit: 500)
        
        let expectation = self.expectation(for: NSPredicate(block: { _, _ in
            accountTwo.balance == 600
        }), evaluatedWith: accountTwo, handler: nil)
        
        DispatchQueue.global(qos: .background).async {
            try? accountOne.transfer(amount: 50, to: accountTwo)
        }
        
        DispatchQueue.global(qos: .background).async {
            try? accountOne.transfer(amount: 50, to: accountTwo)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testConcurrentBankTransfers() throws {
        let accountOne = BankAccount(accountNumber: 0, initialDeposit: 10_000)
        let accountTwo = BankAccount(accountNumber: 0, initialDeposit: 0)
        
        let expectation = self.expectation(for: NSPredicate(block: { _, _ in
            accountTwo.balanceHistory.count == 10_000
        }), evaluatedWith: accountTwo, handler: nil)
        
        let amountToTransfer: Double = 1
        DispatchQueue.concurrentPerform(iterations: 10_000) { i in
            try? accountOne.transfer(amount: amountToTransfer, to: accountTwo)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testProvider() {
        var name: String = ""
        var historyOfNames = [String]()
        let newName = "sfsfs"
        var hasHistoryOfNames: Bool = false
        
        DispatchQueue.concurrentPerform(iterations: 10_000) { i in
            name = newName
            historyOfNames.append(newName)
            hasHistoryOfNames = !historyOfNames.isEmpty
        }
        let expectation = self.expectation(for: NSPredicate(block: { _, _ in
            historyOfNames.count == 10_000
        }), evaluatedWith: nil, handler: nil)
        wait(for: [expectation], timeout: 5.0)
    }
}
