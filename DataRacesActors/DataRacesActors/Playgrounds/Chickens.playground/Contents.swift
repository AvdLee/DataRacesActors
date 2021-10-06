import UIKit

struct Chicken {
    let name: String
    
    func eat(_ amountOfGrain: Int, from grain: inout Int) {
        guard grain > amountOfGrain else { return } // Read
        grain -= amountOfGrain // Write
    }
}

let ammie = Chicken(name: "Ammie")
let poppie = Chicken(name: "poppie")

var amountOfGrain = 100

ammie.eat(80, from: &amountOfGrain)
poppie.eat(20, from: &amountOfGrain)

print(amountOfGrain) // Prints 20

DispatchQueue.global(qos: .background).async {
    ammie.eat(80, from: &amountOfGrain)
}
DispatchQueue.global(qos: .background).async {
    poppie.eat(40, from: &amountOfGrain)
}
