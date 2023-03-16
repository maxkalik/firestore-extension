//
//  User.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

struct User: Response, Identifiable {
    let id: String
    let username: String
    let userpic: String
    let followers: [String]
}
