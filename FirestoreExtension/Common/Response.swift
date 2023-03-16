//
//  Response.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation

protocol Response: Codable { }

struct EmptyResponse: Response {
    init() {}
}

extension String: Response { }
