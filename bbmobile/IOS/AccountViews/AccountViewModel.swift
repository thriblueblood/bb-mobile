//
//  AccountViewModel.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 25/4/2564 BE.
//

import Foundation

import Firebase
class AccountViewModel: ObservableObject{
    
    @Published var isLoading : Bool = false
    @Published var viewState: AccountState = .loading
    @Published var userStatus: Bool = false
    var userName : String = ""
    
    init() {
        getStatus()
    }
    
    public func getName(email: String) -> String {
        var name : String = ""
        for char in email {
            if (char == "@"){
                return name+"'s account"
            }else{
                name += String(char)
            }
        }
        return name+"'s account"
    }
    
    public func getStatus(){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        
        if let UserID = userID{
            db.collection("users").whereField("id", isEqualTo: "\(UserID)").getDocuments() { (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else{
                    if let snapshotDocuments = document?.documents {
                        
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let postBody = data["subscribe"] as? Bool
                            let name = data["email"] as? String
                            
                            self.userName = name ?? " "
                            self.userStatus = postBody!
                        }
                        self.setState(state: .ready)
                    }
                }
            }
        }

    }
   
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
    private func setState(state:AccountState){
        DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading //if state is equal loading then isLoading = true
        }
    }
}

enum AccountState{
    case loading
    case ready
}
