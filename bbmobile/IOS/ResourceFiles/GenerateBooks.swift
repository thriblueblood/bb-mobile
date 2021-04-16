//
//  GenerateMovies.swift
//  iOS
//
//  Created by Nikita Thomas on 8/9/20.
//

import Foundation

func generateBooks(_ count: Int) -> [Book] {
    guard count > 0 else { return [] }
    
    var allBooks: [Book] = []
    
    for _ in 0..<count {
        let id = UUID().uuidString
        
        let nameLength = Int.random(in: 9..<20)
        let name = randomString(length: nameLength)
        
        let randThumbnail = Int.random(in: 0...9)
        let thumbnail = URL(string: "https://picsum.photos/300/10\(randThumbnail)")!
        let author = "AA"
        let categories = ["consectetur", "neque", "felis", "libero"]
        let moreLikeThis = examBooks
        
//        let book = Movie(id: id, name: name, thumbnailURL: thumbnail, categories: categories, genre: .AllGenres, year: year, rating: "PG-13", numberOfSeasons: numSeasons, currentEpisode: defEpiInfo, defaultEpisodeInfo: defEpiInfo, creators: creators, cast: cast, moreLikeThisMovies: moreLikeThis, episodes: allEpisodes, promotionHeadline: headline, trailers: allTrailers)
        let book = Book(id: id, name: name, URL: thumbnail, category: categories, author: author, moreLikeThis:moreLikeThis)
        allBooks.append(book)
    }
    
    return allBooks
}


func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyz"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
