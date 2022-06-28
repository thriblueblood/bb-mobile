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
    private var db : Firestore
    
    @Published var books: [String: [Book]] = [:]
    
    // all book data
    @Published var bookData = [Book]()
    
    // all book by categories
    @Published var mangaBookData = [Book]()
    @Published var fantasyBookData = [Book]()
    @Published var biographyBookData = [Book]()
    @Published var romanceBookData = [Book]()
    @Published var sportBookData = [Book]()
    
    @Published var isLoading : Bool = false
    
    @Published var viewState: AccountState = .loading

    @Published var dataIsLoaded : Bool = false
    
    init() {
        db = Firestore.firestore()
        fetchBookData()
    }
    
    public var allCategories : [String]{
        return books.keys.map({String($0)}) //return the array of string in key's books
    }
    
    //    public var allGenres: [SearchGenres] = [.all,.Crime,.Manga,.Novel]
    
    public func getBook(forCategories : String) -> [Book]{
        return books[forCategories] ?? []
    }
    
    func fetchBookData(){
            self.db.collection("categories").addSnapshotListener { (querySnapshot, error) in
                     guard let documents = querySnapshot?.documents else {
                         print("DEBUG: No documents")
                         return
                     }
                    self.bookData = documents.map({ (queryDocumentSnapshot) -> Book in
                        let data = queryDocumentSnapshot.data()
                       let name = data["title"] as? String
                       let author = data["author"] as? String
                       let overview = data["overview"] as! String
                       let url = data["URL"] as! String
                       let categories = data["category"] as! [String]
                       let content = data["content"] as? String
                        
                        let mangaCate = "Manga"
                        let fantasyCate = "Fantasy"
                        let bioCate = "Biography"
                        let romanceCate = "Romance"
                        let sportCate = "Sport"
                        
                        var currentIndex = 0
                        for cate in categories{
                            if cate == mangaCate{
        //                        print("Found \(cate) for index \(currentIndex)")
                                self.mangaBookData.append(Book( name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                            }
                            else if cate == fantasyCate{
        //                        print("Found \(cate) for index \(currentIndex)")
                                self.fantasyBookData.append(Book(name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                            }
                            else if cate == bioCate{
        //                        print("Found \(cate) for index \(currentIndex)")
                                self.biographyBookData.append(Book(name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                            }
                            else if cate == romanceCate{
        //                        print("Found \(cate) for index \(currentIndex)")
                                self.romanceBookData.append(Book( name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                            }
                            else if cate == sportCate{
                                self.sportBookData.append(Book(name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                            }

                            currentIndex += 1
                        }
                        
                       return Book(name: name ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview, content: URL(string : content ?? ""))
                    })
                print("Book Data", self.bookData)
                self.setState(state: .ready)
                print("Loading", self.isLoading)
                    self.setBookCate()
                
    }
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
            print("BBBBBB")
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
    }

    private func setState(state:AccountState){
        DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading //if state is equal loading then isLoading = true
        }
    }
}


