//
//  FireStoreManager.swift
//  KansTask
//
//  Created by Kareem Abd El Sattar on 19/01/2024.
//

import Foundation
import FirebaseFirestore

protocol TeamFireStore {
    func getTeamPlayers(completion: @escaping (Result<Team, FirestoreError>) -> Void)
}

class DefaultTeamFireStore: TeamFireStore {
    private let db = Firestore.firestore()
    
    func getTeamPlayers(completion: @escaping (Result<Team, FirestoreError>) -> Void){
        db.collection("Teams").document("liverpool").getDocument { snapshot, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            guard let snapshot = snapshot, snapshot.exists else {
                completion(.failure(.noSnapshot))
                return
            }
            
            do {
                let team = try snapshot.decoded() as Team
                completion(.success(team))
            } catch let decodingError {
                completion(.failure(.customError(decodingError)))
            }
        }
    }
}
