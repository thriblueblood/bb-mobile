//
//  MoreLikeThis.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import SwiftUI

struct MoreLikeThis: View {
    var book : [Book]
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView(showsIndicators:false){
            LazyVGrid(columns:columns){
                ForEach(0..<book.count) { index in
                    EachBookHomeView(book: book[index])
                }
            
            }
        }
    }
}

struct MoreLikeThis_Previews: PreviewProvider {
    static var previews: some View {
        MoreLikeThis(book: examBooks)
    }
}
