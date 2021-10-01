//
//  ContentView.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 29/09/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    @State var name: String = ""
    
    init() {
        viewModel = ContentViewModel()
    }
    
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("FROM")
//                    Text("Account: \(viewModel.bankAccountOne.accountNumber)")
//                    Text("Balance: \(viewModel.bankAccountOne.balance)")
//                }
//                VStack(alignment: .leading) {
//                    Text("TO")
//                    Text("Account: \(viewModel.bankAccountTwo.accountNumber)")
//                    Text("Balance: \(viewModel.bankAccountTwo.balance)")
//                }
//            }.padding()
//            HStack {
//                Button("Transfer 200") {
//                    viewModel.transfer(amount: 200)
//                }
//                Button("Transfer 500") {
//                    viewModel.transfer(amount: 500)
//                }
//            }
//        }
//    }
    
    var body: some View {
        VStack {
            Button("Increment count") {
                viewModel.incrementCounter()
            }
        }.padding()
    }
    
//    var body: some View {
//        VStack {
//            TextField("Your name:", text: $name, prompt: nil)
//            Button("Submit new name") {
//                viewModel.updateName(newName: name)
//            }
//        }.padding()
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
