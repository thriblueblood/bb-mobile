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
    
    init(){
        db = Firestore.firestore()
    }
    
    func fetchBookData(){
        DispatchQueue.main.async{
            self.db.collection("test").addSnapshotListener { (snap, err) in
                if (err != nil){
                    print((err?.localizedDescription)!)
                    return
                }
                for i in snap!.documentChanges{
                    let id = i.document.documentID
                    let name = i.document.get("title") as? String
                    let author = i.document.get("author") as? String
                    let overview = i.document.get("overview") as! String
                    let url = i.document.get("URL") as! String
                    let pages = i.document.get("pages") as! [String]
                    let categories = i.document.get("category") as! [String]
                    let content = i.document.get("content") as! String
                    
                    self.books.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, pages: pages, author: author, overview: overview, content: URL(string : content)))
                }
            }
        }
    }
}

