//
//  BankAccountTests.swift
//  DataRacesActorsTests
//
//  Created by Antoine van der Lee on 29/09/2021.
//

import XCTest
@testable import DataRacesActors

class BankAccountTests: XCTestCase {
    
    /// An example of a race condition.
    /// If there's no locking mechanism in place, both 50 and 70 transfer will continue
    /// and bank account two will end up with a balance of 100 + 50 + 70 = 220.
    /// As account one only contains 100, this should not be possible.
    func testBankTransferThreading() async throws {
        let accountOne = BankAccount(initialDeposit: 100)
        let accountTwo = BankAccount(initialDeposit: 100)
        
        let transferExpectation = expectation(description: "Transfers should finish")
        transferExpectation.expectedFulfillmentCount = 2
        
        concurrentlyPerform {
            try? accountOne.transfer(amount: 50, to: accountTwo)
            transferExpectation.fulfill()
        }
        
        concurrentlyPerform {
            try? accountOne.transfer(amount: 70, to: accountTwo)
            transferExpectation.fulfill()
        }
        
        wait(for: [transferExpectation], timeout: 5.0)
        
        let accountOneBalance = accountOne.balance
        let accountTwoBalance = accountTwo.balance
        XCTAssertEqual(accountOneBalance, 50)
        XCTAssertEqual(accountTwoBalance, 150)
    }
    
    /// When many transfers occur at the same time, threading can become a problem.
    /// Data races will turn into exceptions like EXC_BAD_ACCESS.
    func testManyConcurrentBankTransfers() throws {
        let numberOfConcurrentTransfers = 10_000
        let amountToTransfer: Double = 1
        
        let accountOne = BankAccount(initialDeposit: Double(numberOfConcurrentTransfers))
        let accountTwo = BankAccount(initialDeposit: 0)
        
        let transferExpectation = expectation(description: "Transfers should finish")
        transferExpectation.expectedFulfillmentCount = numberOfConcurrentTransfers
        DispatchQueue.concurrentPerform(iterations: numberOfConcurrentTransfers) { i in
            try? accountOne.transfer(amount: amountToTransfer, to: accountTwo)
            transferExpectation.fulfill()
        }
        
        wait(for: [transferExpectation], timeout: 10.0)
    }
}

extension BankAccountTests {
    func concurrentlyPerform(_ task: @escaping () async -> Void) {
        DispatchQueue.global(qos: .background).async {
            Task(priority: .background) {
                await task()
            }
        }
    }
}
