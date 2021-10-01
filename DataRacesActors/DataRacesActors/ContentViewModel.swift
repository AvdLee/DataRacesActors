//
//  ContentViewModel.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 29/09/2021.
//

import Foundation

final class ContentViewModel: ObservableObject {
    
    private(set) var name: String = ""
    private(set) var hasHistoryOfNames: Bool = false
    
    private var apiProvider: APIProvider = APIProvider()
    private var historyOfNames: [String] = []
    
    private var count = 0
    private var historyOfNumbers: [Int] = []
    private var isEvenCount: Bool = true
    private var isIncrementing: Bool = false
    
    let bankAccountOne = BankAccount(accountNumber: 0, initialDeposit: 500)
    let bankAccountTwo = BankAccount(accountNumber: 1, initialDeposit: 200)
    
    func updateName(newName: String) {
        apiProvider.updateNameInBackend(newName: newName) {
            self.name = newName
            self.historyOfNames.append(newName)
            self.hasHistoryOfNames = !self.historyOfNames.isEmpty
        }
    }
    
    func incrementCounter() {
//        guard !isIncrementing else { return }
//        DispatchQueue.global(qos: .background).async {
//            count = count + 1
//            print("Count is now \(]\count")
//        }
    }
    
    func transfer(amount: Double) {
        try? bankAccountOne.transfer(amount: amount, to: bankAccountTwo)
    }
}

final class BankAccount {
    enum BankError: Error {
        case insufficientFunds
    }
    
    let accountNumber: Int
    var balance: Double
    
    private(set) var balanceHistory: [Double] = []
    private(set) var hasBalanceHistory: Bool = false
    
    init(accountNumber: Int, initialDeposit: Double) {
        self.accountNumber = accountNumber
        self.balance = initialDeposit
    }
    
    func transfer(amount: Double, to other: BankAccount) throws {
        if amount > balance {
            throw BankError.insufficientFunds
        }
        
        print("Transferring \(amount) from \(accountNumber) to \(other.accountNumber)")
        balanceHistory.append(amount)
        hasBalanceHistory = !balanceHistory.isEmpty
        
        balance = balance - amount
        other.balance = other.balance + amount
    }
}
