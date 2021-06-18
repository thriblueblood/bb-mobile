//
//  BookDetailViewModel.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 25/4/2564 BE.
//

import Foundation
import Firebase
class BookDetailViewModel: ObservableObject{
    
    @Published var userStatus: Bool = false
    
    public func getUserData(){
        
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
                        let postBody = data["subscribe"] as? Bool
                        print(postBody!)
                        self.userStatus = postBody!
                        print(data)
                    }
                    
                    
                }
                
            
                
            }
        }
        
    }
}
