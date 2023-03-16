//
//  Firestore.swift
//  FirestoreExtension
//
//  Created by Maksim Kalik on 3/16/23.
//

import Foundation
import FirebaseFirestore

extension Firestore {
    static var db = Firestore.firestore()
}

// MARK: - Get Document

extension Firestore {
    
    static func get<R: Request>(request: R) async throws -> R.Output? {
        try await get(request.path)
    }
    
    static func get<T: Codable>(_ path: String) async throws -> T? {
        try await db.document(path)
            .getDocument()
            .data(as: T.self)
    }
}

// MARK: - Get Documents from Collection

extension Firestore {
    
    static func get<R: Request>(request: R) async throws -> [R.Output] {
        guard let limit = request.limit else {
            return try await self.get(request.path)
        }
        
        return try await db.collection(request.path)
            .limit(to: limit)
            .getDocuments()
            .documents
            .compactMap { $0.data(as: R.Output.self) }
    }

    static func get<T: Codable>(_ path: String) async throws -> [T] {
        try await db.collection(path)
            .getDocuments()
            .documents
            .compactMap { $0.data(as: T.self) }
    }
}

// MARK: - Document Listening

extension Firestore {

    static func listenDocument<R: Request>(request: R, completion: @escaping (Result<R.Output, FirestoreError>) -> Void) {
        let ref: DocumentReference = db.document(request.path)
        listenDocument(ref, completion: completion)
    }

    static func listenDocument<T: Codable>(_ ref: DocumentReference, completion: @escaping (Result<T, FirestoreError>) -> Void) {
        ref.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(.error(error)))
            } else if let result: T = snapshot?.data(as: T.self) {
                completion(.success(result))
            } else {
                completion(.failure(.noData))
            }
        }
    }
}

// MARK: - Collection Listening

extension Firestore {

    static func listenDocuments<R: Request>(request: R, completion: @escaping (Result<[R.Output], FirestoreError>) -> Void) {
        var query: Query = db.collection(request.path)
        if let predicate = request.queryPredicate {
            query = query.filter(using: predicate)
        }
        
        listenDocuments(query, completion: completion)
    }
    
    static func listenDocuments<T: Codable>(_ query: Query, completion: @escaping (Result<[T], FirestoreError>) -> Void) {
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(.error(error)))
            } else if let result: [T] = snapshot?.documents.compactMap({ $0.data(as: T.self) }) {
                completion(.success(result))
            } else {
                completion(.success([]))
            }
        }
    }
}

// MARK: - Updating Document

extension Firestore {
    static func update<R: Request>(request: R) async throws {
        try await update(
            data: request.updatedDataFields?.dictionary ?? [:],
            path: request.path
        )
    }
    
    static func update(data: [AnyHashable: Any], path: String) async throws {
        try await db.document(path).updateData(data)
    }
}
