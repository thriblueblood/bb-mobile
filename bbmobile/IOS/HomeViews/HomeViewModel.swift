//
//  HomeViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import Foundation
import Firebase
import SwiftUI

class HomeViewModel: ObservableObject{
    
    //Key Value is Category
    
    @Published var books: [String: [Book]] = [:]
    @Published var bookData = [Book]()
    @Published var dataIsLoaded : Bool = false
    
    init(){
        loadData()
    }
    
    public var allCategories : [String]{
        print("Called")
        return books.keys.map({String($0)}) //return the array of string in key's books
    }
    
    //    public var allGenres: [SearchGenres] = [.all,.Crime,.Manga,.Novel]
    
    public func getBook(forCategories : String) -> [Book]{
        return books[forCategories] ?? []
    }
    
    func loadData(){
        
        let group = DispatchGroup()
        group.enter()
        let db = Firestore.firestore()
        db.collection("categories").addSnapshotListener { (snap, err) in
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("title") as? String
                let author = i.document.get("author") as! String
                let overview = i.document.get("overview") as! String
                let url = i.document.get("URL") as! String
                let pages = i.document.get("pages") as! [String]
                let categories = i.document.get("category") as! [String]
                self.bookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, pages: pages, author: author, overview: overview))
            }
        group.leave()
        }
    
       
        group.notify(queue: DispatchQueue.global(qos: .background)){
            self.setBookCate()
//            print("Book Data ", self.bookData)
        }
    }
//    func getBookData(){
        

       


//    }
    func setBookCate(){
        DispatchQueue.main.async{
            self.books["Best of All time"] = self.bookData//keys is best of all time and value is examBook
            self.books["Manga"] = examBooks
            self.books["Novel"] = examBooks
            self.books["Popular right now"] = examBooks
            self.books["Mystery"] = examBooks
            self.dataIsLoaded = true
           
        }
        print("Data loaded")
    }

}


