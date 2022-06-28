//
//  RegisterViewModel.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 25/4/2564 BE.
//

import Foundation
import Firebase
import SwiftUI

class RegisterViewModel: ObservableObject{
    
    func register(email : String, password : String){
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err{
                print(err.localizedDescription)
            }
            else{
                print("success")
                let db = Firestore.firestore()
                db.collection("users").document("\(email)").setData([
                    "id": "",
                    "email": email,
                    "password": password,
                    "subscribe": false,
                    "isAdmin": false,
                    "myList" : []
                ])
            }
        }
        
    }
    
}
