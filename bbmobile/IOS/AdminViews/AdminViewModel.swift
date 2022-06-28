//
//  AdminBookDetailViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 11/6/2564 BE.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AdminViewModel : ObservableObject{
    @Published var books : [Book] = []
    private var db : Firestore
    
    @Published var loadingState : LoadingState = .idle
    
    // For track the multiple append
    @Published var booksString : [String] = []
    
    init(){
        db = Firestore.firestore()
    }
    
    func fetchBookData(){
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
            self.db.collection("categories").addSnapshotListener { (querySnapshot, error) in
                     guard let documents = querySnapshot?.documents else {
                         print("DEBUG: No documents")
                        DispatchQueue.main.async {
                            self.loadingState =  .failure
                        }
                         return
                     }
                DispatchQueue.main.async {
                    self.books = documents.map({ (queryDocumentSnapshot) -> Book in
                        let data = queryDocumentSnapshot.data()
                       let name = data["title"] as? String
                       let author = data["author"] as? String
                       let overview = data["overview"] as! String
                       let url = data["URL"] as! String
                       let categories = data["category"] as! [String]
                       let content = data["content"] as? String
                       return Book(name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview, content: URL(string : content ?? ""))

                    })
                    self.loadingState = .success
                }
                 }
    }
    
    func signout(){
            do{
                try Auth.auth().signOut()
            }
            catch{
                print("error")
            }

        }
}

