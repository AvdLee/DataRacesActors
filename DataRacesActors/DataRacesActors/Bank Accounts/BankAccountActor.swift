//
//  BankAccountActor.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 01/10/2021.
//

import Foundation

/// The actor makes sure access is synchronized.
actor BankAccountActor {
    enum BankError: Error {
        case insufficientFunds
    }
    
    var balance: Double
    
    init(initialDeposit: Double) {
        self.balance = initialDeposit
    }
    
    func transfer(amount: Double, to toAccount: BankAccountActor) async throws {
        guard balance >= amount else {
            throw BankError.insufficientFunds
        }
        balance -= amount
        await toAccount.deposit(amount: amount)
    }
    
    func deposit(amount: Double) {
        balance = balance + amount
    }
}
