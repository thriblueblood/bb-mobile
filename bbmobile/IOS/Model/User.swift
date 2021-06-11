//
//  Episode.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import Foundation

struct User {
    var id = UUID().uuidString
    var name : String
    var Image : URL?
    var isAdmin : Bool
    var favorite : [Book]?
}
