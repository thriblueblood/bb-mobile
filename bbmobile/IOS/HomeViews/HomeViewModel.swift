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
    
    // all book data
    @Published var bookData = [Book]()
    
    // all book by categories
    @Published var mangaBookData = [Book]()
    @Published var fantasyBookData = [Book]()
    @Published var biographyBookData = [Book]()
    @Published var romanceBookData = [Book]()
    @Published var sportBookData = [Book]()

    @Published var dataIsLoaded : Bool = false
    
    init() {
        self.loadData()
    }
    public var allCategories : [String]{
        return books.keys.map({String($0)}) //return the array of string in key's books
    }
    
    //    public var allGenres: [SearchGenres] = [.all,.Crime,.Manga,.Novel]
    
    public func getBook(forCategories : String) -> [Book]{
        return books[forCategories] ?? []
    }
    
//    init() {
//        loadData()
//    }
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
                let author = i.document.get("author") as? String
                let overview = i.document.get("overview") as! String
                let url = i.document.get("URL") as! String
                let categories = i.document.get("category") as! [String]
                let content = i.document.get("content") as? String
                
                let mangaCate = "Manga"
                let fantasyCate = "Fantasy"
                let bioCate = "Biography"
                let romanceCate = "Romance"
                let sportCate = "Sport"
                
                var currentIndex = 0
                for cate in categories{
                    if cate == mangaCate{
//                        print("Found \(cate) for index \(currentIndex)")
                        self.mangaBookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                    }
                    else if cate == fantasyCate{
//                        print("Found \(cate) for index \(currentIndex)")
                        self.fantasyBookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                    }
                    else if cate == bioCate{
//                        print("Found \(cate) for index \(currentIndex)")
                        self.biographyBookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                    }
                    else if cate == romanceCate{
//                        print("Found \(cate) for index \(currentIndex)")
                        self.romanceBookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                    }
                    else if cate == sportCate{
                        self.sportBookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                    }

                    currentIndex += 1
                }
                
                    
                self.bookData.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview, content: URL(string :content ?? "")))
            }
        group.leave()
        }
    
       
        group.notify(queue: DispatchQueue.global(qos: .background)){
            self.setBookCate()

        }
    }
    
    func setBookCate(){
        DispatchQueue.main.async{
            self.books["All book"] = self.bookData//keys is best of all time and value is examBook
            self.books["Manga"] = self.mangaBookData
            self.books["Historical Person"] = self.biographyBookData
            self.books["Fantasy"] = self.fantasyBookData
            self.books["Romance"] = self.romanceBookData
            self.books["Sport"] = self.sportBookData
            self.dataIsLoaded = true
        }
//        print("Data loaded")
    }

}


