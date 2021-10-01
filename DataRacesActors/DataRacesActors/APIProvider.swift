//
//  APIProvider.swift
//  DataRacesActors
//
//  Created by Antoine van der Lee on 29/09/2021.
//

import Foundation

final class APIProvider {
    func updateNameInBackend(newName: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.concurrentPerform(iterations: 1_000_000) { i in
                completion()
            }
        }
    }
}
