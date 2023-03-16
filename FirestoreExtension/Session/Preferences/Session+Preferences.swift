//
//  Session+Preferences.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation
import FirebaseFirestore

extension Session {
    func fetchPreferences() async throws -> Preferences? {
        let request = PreferencesRequest()
        return try await Firestore.get(request: request)
    }

    func observePreferences() {
        let request = PreferencesRequest()
        Firestore.listenDocument(request: request) { result in
            switch result {
            case .success(let output):
                print(output)
            case .failure(let error):
                print(error)
            }
        }
    }
}
