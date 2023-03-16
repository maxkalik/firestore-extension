//
//  PreferencesRequest.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

struct PreferencesRequest: Request {
    typealias Output = Preferences
    var path: String = "config/preferences"
}
