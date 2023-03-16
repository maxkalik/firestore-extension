//
//  PreferencesResponse.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

struct Preferences: Response {
    let name: String
    let message: String?
    let version: Int
}
