//
//  EachBookHomeView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct EachBookHomeView: View {
    var book : Book
    var body: some View {
        KFImage(book.URL)
            .resizable()
            .scaledToFill()
    }
}

struct EachBookHomeView_Previews: PreviewProvider {
    static var previews: some View {
        EachBookHomeView(book: examBook1)
    }
}
