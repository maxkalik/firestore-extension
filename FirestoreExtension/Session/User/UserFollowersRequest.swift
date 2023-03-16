//
//  UserRequest.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

struct UserFollowersRequest: Request {
    typealias Output = User
    var path: String
    var queryPredicate: NSPredicate?
    
    init(id: String) {
        self.path = "users/"
        self.queryPredicate = NSPredicate(format: "followers CONTAINS %@", id)
    }
}
