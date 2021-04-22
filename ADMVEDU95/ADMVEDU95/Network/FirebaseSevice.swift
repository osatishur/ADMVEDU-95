//
//  FirebaseSevice.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import Foundation
import FirebaseAuth

class FirebaseService {
    func createUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let error = error {
                print("failed to sign up user", error.localizedDescription)
                completion(.failure(error))
            }
            if let _ = authResult?.user {
                completion(.success(true))
            }
            
            if error == nil && authResult?.user == nil {
                completion(.success(false))
            }
        }
    }
    
    func logIn(email: String, pass: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let _ = result {
                print("Successfully logged in")
                completion(.success(true))
            }
            if error == nil && result == nil {
                completion(.success(false))
            }
        }
    }
    
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                completion(.success(true))
            }
        }
    }
}
