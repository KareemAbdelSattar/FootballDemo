//
//  FireStoreError.swift
//  KansTask
//
//  Created by Kareem Abd El Sattar on 19/01/2024.
//

import Foundation

enum FirestoreError: Error {
    case noSnapshot
    case noPlayersField
    case customError(Error)
}
