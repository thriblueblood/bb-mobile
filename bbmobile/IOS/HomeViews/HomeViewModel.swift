//
//  HomeViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    //Key Value is Category
    @Published var books: [String: [Book]] = [:]
    
    public var allCategories : [String]{
        books.keys.map({String($0)}) //return the array of string in key's books
    }
    
//    public var allGenres: [SearchGenres] = [.all,.Crime,.Manga,.Novel]
    
    public func getBook(forCategories : String) -> [Book]{
        return books[forCategories] ?? []
    }
    
    
    init(){
       setBookCate()
    }
    
    func setBookCate(){
        books["Best of All time"] = examBooks//keys is best of all time and value is examBook
        books["Manga"] = examBooks
        books["Novel"] = examBooks
        books["Popular right now"] = examBooks
        books["Mystery"] = examBooks
    }
}

//enum SearchGenres : String {
//    case all
//    case Novel
//    case Manga
//    case Crime
//}
