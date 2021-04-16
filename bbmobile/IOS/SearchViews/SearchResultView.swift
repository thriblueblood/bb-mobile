//
//  SearchResultView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 16/4/2564 BE.
//

import SwiftUI

struct SearchResultView: View {
    var books : [Book]
    @Binding var showBookDetail : Book?
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns,spacing:10,content: {
            ForEach(books, id: \.id){book in
                EachBookHomeView(book: book)
                    .onTapGesture {
                        self.showBookDetail = book
                    }
            }
        })
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(books: examBooks, showBookDetail: .constant(nil))
    }
}
