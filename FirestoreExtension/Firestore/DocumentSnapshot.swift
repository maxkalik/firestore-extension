//
//  DocumentSnapshot.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import FirebaseFirestore

extension DocumentSnapshot {
    
    func data<T: Codable>(as: T.Type) -> T? {
        data()?.toCodable(of: T.self)
    }
}
