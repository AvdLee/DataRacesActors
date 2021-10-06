import UIKit

class BankAccount {
    var balance: Double
    let serialLockQueue = DispatchQueue(label: "banking.lock.queue")
    
    init(initialDeposit: Double) {
        self.balance = initialDeposit
    }
    
    func transfer(amount: Double, to other: BankAccount) {
        guard balance > amount else { return } // Read
        balance -= amount // Write
        other.balance += amount // Write
    }
}

let bankAccountOne = BankAccount(initialDeposit: 100)
let bankAccountTwo = BankAccount(initialDeposit: 100)


bankAccountOne.transfer(amount: 50, to: bankAccountTwo)
bankAccountOne.transfer(amount: 70, to: bankAccountTwo)

print(bankAccountOne.balance) // Prints 50

DispatchQueue.global(qos: .background).async {
    bankAccountOne.transfer(amount: 50, to: bankAccountTwo)
}
DispatchQueue.global(qos: .background).async {
    bankAccountOne.transfer(amount: 70, to: bankAccountTwo)
}
