//
//  GlobalHelper.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import Foundation
import SwiftUI
import Firebase

let examBook1 = Book(id:UUID().uuidString, name:"Attack on Titan Vol.19", URL: URL(string:"https://i.pinimg.com/originals/1e/86/92/1e86928509e50979ffe592444dadb987.jpg")!,
                     category: ["Action fiction","Dark Fantasy"], pages: ["https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_1.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_2.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_3.jpg"],author:"Hajime Isayama",overview:"A century ago, the grotesque giants known as Titans appeared and consumed all but a few thousand humans. The survivors took refuge behind giant walls. Today, the threat of the Titans is a distant memory, and a boy named Eren yearns to explore the world beyond Wall Maria. But what began as a childish dream will become an all-too-real nightmare when the Titans return and humanity is once again on the brink of extinction ? ",episode:[examEpisode1,examEpisode2], moreLikeThis: [examBook5,examBook6])

let examBook2 = Book(id:UUID().uuidString, name:"Harry Potter", URL: URL(string:"https://images-na.ssl-images-amazon.com/images/I/81iqZ2HHD-L.jpg")!, category: ["Fantasy"], pages: ["https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_1.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_2.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_3.jpg"], moreLikeThis: [])

let examBook3 = Book(id:UUID().uuidString, name:"Boku no Hero Academia Vol.29", URL: URL(string:"https://pbs.twimg.com/media/EqASVivUUAEqmps.jpg")!, category: ["Manga", "Action ficiton"], pages: ["https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_1.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_2.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_3.jpg"], author:"Kohei Horikoshi",overview: "デッカい男のせいで、辺り一帯がメチャクチャ！　「主のもとへ」って、死柄木？　……ダメ！　こいつが街に降りたら、ひとたまりもない！　雄英生も危険じゃない！　蛇腔病院側で何が!?　い・い・か・ら、止まれぇぇええええ!!　“Plus Ultra”!!",episode:[examEpisode1,examEpisode2], moreLikeThis: [examBook1,examBook5,examBook6])

let examBook4 = Book(id:UUID().uuidString, name:"Sherlock Holmes", URL: URL(string:"https://images-na.ssl-images-amazon.com/images/I/71+WebeovJL.jpg")!, category: ["Mystery","Crime"], pages: ["https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_1.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_2.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_3.jpg"], moreLikeThis: [])

let examBook5 = Book(id:UUID().uuidString, name:"Attack on Titan Vol.33", URL: URL(string:"https://cdn.archonia.com/images/1-104014355-1-1-original1/attack-on-titan-vol-33-gn.jpg")!, category: ["Action fiction","Dark Fantasy"], pages: ["https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_1.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_2.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_3.jpg"],author: "Hajime Isayama",overview: "A century ago, the grotesque giants known as Titans appeared and consumed all but a few thousand humans. The survivors took refuge behind giant walls. Today, the threat of the Titans is a distant memory, and a boy named Eren yearns to explore the world beyond Wall Maria. But what began as a childish dream will become an all-too-real nightmare when the Titans return and humanity is once again on the brink of extinction ? ", moreLikeThis: [])

let examBook6 = Book(id:UUID().uuidString, name:"Dragon Ball Super Vol.11", URL: URL(string:"https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781974717613/dragon-ball-super-vol-11-9781974717613_hr.jpg")!, category: [
                        "Adventure Fiction"], pages: ["https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_1.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_2.jpg","https://images.mangafreak.net/mangas/my_hero_academia/my_hero_academia_299/my_hero_academia_299_3.jpg"], moreLikeThis:[])

var examBooks:[Book] {
    return [examBook1,examBook2,examBook3,examBook4,examBook5,examBook6].shuffled()
}

let examEpisode1 = Episode(name: "#277 : Who...??",Image:URL(string: "https://static.wikia.nocookie.net/bokunoheroacademia/images/6/6a/Chapter_277.png/revision/latest?cb=20210103224935")!)
let examEpisode2 = Episode(name: "#278 : Disaster Walker",Image:URL(string: "https://i.pinimg.com/originals/a4/00/b7/a400b7e9efc493c8048896f3d899c69a.jpg")!)

extension String{
    func widthOfString (usingFont font:UIFont) -> CGFloat{
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
