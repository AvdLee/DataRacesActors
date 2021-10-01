//
//  BankAccount.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 01/10/2021.
//

import Foundation

/// The type of bank account to use for the app.
/// - `BankAccountUnsynchronized`: No thread safety at all.
/// - `BankAccountSynchronized`: Thread safety with a `DispatchQueue` as lock.
/// - `BankAccountActor`: Thread safety by using an `actor`.
typealias BankAccount = BankAccountUnsynchronized
