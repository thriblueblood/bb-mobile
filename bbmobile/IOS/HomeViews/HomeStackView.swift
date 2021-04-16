//
//  HomeStackView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 13/4/2564 BE.
//

import SwiftUI

struct HomeStackView: View {
    
    var viewModel : HomeViewModel
    @Binding var showBookDetail:Book?
    
    var body: some View {
        ForEach(viewModel.allCategories, id:\.self) { category in
            VStack{
                HStack{
                    Text(category)
                        .padding(.leading,0)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(viewModel.getBook(forCategories: category)) { book in
                            EachBookHomeView(book: book)
                                .frame(width:100, height:200)
                                .padding(.horizontal,20)
                                .onTapGesture(perform: {
                                    showBookDetail = book
                                })
                        }
                    }
                }
                .padding(.top,-5)
            }.font(.custom("Lato-Bold", size: 16))
            
            
        }
    }
}
