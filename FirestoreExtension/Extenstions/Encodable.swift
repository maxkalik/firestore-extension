//
//  Encodable.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = self.data else { return nil }
        return (
            try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
            )
        )
        .flatMap { $0 as? [String: Any] }
    }
    
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}
