//
//  BankAccountSynchronized.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 01/10/2021.
//

import Foundation

/// A lock queue makes sure access is synchronized.
final class BankAccountSynchronized {
    enum BankError: Error {
        case insufficientFunds
    }
    
    private let lockQueue = DispatchQueue(label: "bank.lock.queue")
    
    private(set) var balance: Double
    private(set) var balanceHistory: [Double] = []
    private(set) var hasBalanceHistory: Bool = false
    
    init(initialDeposit: Double) {
        self.balance = initialDeposit
    }
    
    func transfer(amount: Double, to other: BankAccountSynchronized) throws {
        try lockQueue.sync {
            if amount > balance {
                throw BankError.insufficientFunds
            }
            
            balanceHistory.append(amount)
            hasBalanceHistory = !balanceHistory.isEmpty
            
            print("Transfered \(amount) new balance is \(balance)")
            
            balance = balance - amount
            other.deposit(amount: amount)
        }
    }
    
    func deposit(amount: Double) {
        balance = balance + amount
    }
}
