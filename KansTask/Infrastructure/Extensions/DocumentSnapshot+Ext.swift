//
//  DocumentSnapshot+Ext.swift
//  KansTask
//
//  Created by Kareem Abd El Sattar on 19/01/2024.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    func decoded<Type: Codable>() throws -> Type {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data() ?? [:], options: []) else {
            throw NSError(domain: "FirestoreDecoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document data was not a valid JSON"])
        }
        return try JSONDecoder().decode(Type.self, from: jsonData)
    }
}
