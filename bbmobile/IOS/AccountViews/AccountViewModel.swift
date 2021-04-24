//
//  AccountViewModel.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 25/4/2564 BE.
//

import Foundation

import Firebase
class AccountViewModel: ObservableObject{
    
    @Published var userStatus: Bool = false
   
    public func switchStatus(){
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser!.uid
        
        db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments() { (document, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else{
                if let snapshotDocuments = document?.documents {
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        let email = data["email"] as? String
                        let postBody = data["subscribe"] as? Bool
                        print(postBody!)
                        print(email)
                        if postBody! == false{
                            db.collection("users").document("\(email!)").updateData([
                                "subscribe": true
                            ])
                            self.userStatus = true
                            print("userStatusTRUE?",self.userStatus)
                        }
                        else{
                            db.collection("users").document("\(email!)").updateData([
                                "subscribe": false
                            ])
                            self.userStatus = false
                            print("userStatusFALSE?",self.userStatus)
                        }
                    }
                    
                    
                }
                
            
                
            }
        }
        
    }
}
