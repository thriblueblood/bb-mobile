//
//  RegisterViewModel.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 25/4/2564 BE.
//

import Foundation
import Firebase
final class RegisterViewModel: ObservableObject{
    private let path = "users"
    private let store = Firestore.firestore()
    @Published var user: [User] = []
    
//    func add(_ user: User){
//        do{
//            _ = try store.collection(path).addDocument(from: user)
//        } catch{
//            fatalError("Adding a book failed")
//        }
//    }
}
