//
//  Book.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import Foundation

struct Book : Identifiable {
    var id : String
    var name : String
    var URL : URL
    var category : [String]
    var pages: [String]
    var author : String?
    var overview : String?
    
    var numberOfEpisode : Int?
    var episode : [Episode]?
    
    var moreLikeThis : [Book]?
    
    var numberOfEpisodeDisplay : String{
        if let n = numberOfEpisode{
            if(n==1){
                return "1 episode"
            }else{
                return "\(n) episodes"
            }
        }
        return ""
    }
}
