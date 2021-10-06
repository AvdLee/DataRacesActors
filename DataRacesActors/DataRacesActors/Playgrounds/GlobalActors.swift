//
//  GlobalActors.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 05/10/2021.
//

import Foundation
import UIKit

final class BankAccountsViewModel {
    // ..
 
    /// Isolated to the main actor.
    @MainActor var images: [UIImage] = []
    
    
    func thisExecutesOnTheMainThread() { }
   
    // Closure isolates to the main actor.
    func updateData(completion: @MainActor @escaping () -> ()) {

    }
}




