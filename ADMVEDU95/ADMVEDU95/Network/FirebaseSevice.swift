//
//  FirebaseSevice.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import Foundation
import FirebaseAuth

class FirebaseService {
    func createUser(email: String, password: String, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let error = error {
                print("failed to sign up user", error.localizedDescription)
                completionBlock(.failure(error))
            }
            if let _ = authResult?.user {
                completionBlock(.success(true))
            }
        }
    }
    
    func logIn(email: String, pass: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                print("Successfully signed in")
                completion(.success(true))
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            let navVC = UINavigationController(rootViewController: LoginViewController())
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navVC)
        } catch let error {
            print("failed to log out with error", error.localizedDescription)
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
