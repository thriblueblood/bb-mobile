//
//  GlobalHelper.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import Foundation

let examBook1 = Book(id:UUID().uuidString, name:"Attack on Titan Vol.19", URL: URL(string:"https://i.pinimg.com/originals/1e/86/92/1e86928509e50979ffe592444dadb987.jpg")!,
                     category: ["Action fiction","Dark Fantasy"])

let examBook2 = Book(id:UUID().uuidString, name:"Harry Potter", URL: URL(string:"https://images-na.ssl-images-amazon.com/images/I/81iqZ2HHD-L.jpg")!, category: ["Fantasy"])

let examBook3 = Book(id:UUID().uuidString, name:"Boku no Hero Academia Vol.29", URL: URL(string:"https://pbs.twimg.com/media/EqASVivUUAEqmps.jpg")!, category: ["Manga", "Action ficiton"])

let examBook4 = Book(id:UUID().uuidString, name:"Sherlock Holmes", URL: URL(string:"https://images-na.ssl-images-amazon.com/images/I/71+WebeovJL.jpg")!, category: ["Mystery","Crime"])

let examBook5 = Book(id:UUID().uuidString, name:"Attack on Titan Vol.33", URL: URL(string:"https://cdn.archonia.com/images/1-104014355-1-1-original1/attack-on-titan-vol-33-gn.jpg")!, category: ["Action fiction","Dark Fantasy"])

let examBook6 = Book(id:UUID().uuidString, name:"Dragon Ball Super Vol.11", URL: URL(string:"https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781974717613/dragon-ball-super-vol-11-9781974717613_hr.jpg")!, category: [
"Adventure Fiction"])

let examBooks:[Book] = [examBook1,examBook2,examBook3,examBook4,examBook5,examBook6]

