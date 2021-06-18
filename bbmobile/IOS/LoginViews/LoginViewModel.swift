//
//  LoginViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 17/6/2564 BE.
//

import Foundation
import Firebase
import SwiftUI

enum checkState {
    case idle
    case success
}

class LoginViewModel : ObservableObject{
    
    var mode : checkState = .idle
    @Published  var userType : Bool = true
    
    func login(email : String, password : String, completion: @escaping () -> Void){
        let db = Firestore.firestore()
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if err != nil{
                print(err?.localizedDescription ?? "")
            }
            else{
                let userID = Auth.auth().currentUser!.uid
                db.collection("users").document("\(email)").updateData([
                    "id": "\(userID)"
                ])
                completion()
            }
        }
        
    }
    
    func checkUserType(){
        let db = Firestore.firestore()
        if let userID = Auth.auth().currentUser?.uid{
            db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments() { (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else{
                    if let snapshotDocuments = document?.documents {
                        
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let type = data["isAdmin"] as? Bool
                            DispatchQueue.main.async {
                                self.userType = type!
                                print("Admin ? ", self.userType)
                                self.mode = .success
                                print("Mode:", self.mode)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
