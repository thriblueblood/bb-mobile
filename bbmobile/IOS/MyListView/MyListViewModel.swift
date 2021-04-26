//
//  MyListViewModel.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 26/4/2564 BE.
//

import Foundation
import Firebase


class MyListViewModel: ObservableObject{
    @Published var myList = [Book]()
    var myListInString: [String]?
    
    
    init(){
        print("ffff")
        print(self.myList)
        getMyListData()
        displayData()
        
    }
    
    public func addToMyList(bookname: String){
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
                        
                        self.myListInString = data["myList"] as? [String]
                        
                        
                        db.collection("users").document("\(email!)").updateData([
                            "myList": FieldValue.arrayUnion([bookname])
                        ])
                        
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
    }
    func getMyListData(){
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
                        
                        let myList = data["myList"] as? [String]
                        
                        
                        
                        
                    }
       
                }
                
                
            }
            
        }
    }
    func displayData(){
        for name in myList{
            let db = Firestore.firestore()
            db.collection("categories").whereField("title",isEqualTo: name).addSnapshotListener { (snap, err) in
                if (err != nil){
                    print((err?.localizedDescription)!)
                    return
                }
                for i in snap!.documentChanges{
                    print("NAME: ",name)
                    let id = i.document.documentID
                    let name = i.document.get("title") as? String
                    let author = i.document.get("author") as! String
                    let overview = i.document.get("overview") as! String
                    let url = i.document.get("URL") as! String
                    let pages = i.document.get("pages") as! [String]
                    let categories = i.document.get("category") as! [String]
                    self.myList.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, pages: pages, author: author, overview: overview))
                    
                }
            }
        }
    }
}
