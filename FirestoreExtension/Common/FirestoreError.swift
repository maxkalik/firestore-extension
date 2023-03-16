//
//  FirestoreError.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

enum FirestoreError: Error {
    case error(Error)
    case noData
}
