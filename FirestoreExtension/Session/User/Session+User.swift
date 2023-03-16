//
//  Session+User.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension Session {

    func observeUserFollowers() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let request = UserFollowersRequest(id: id)
        Firestore.listenDocuments(request: request) { result in
            switch result {
            case .success(let output):
                print(output)
            case .failure(let error):
                print(error)
            }
        }
    }
}
