//
//  MyListView.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 26/4/2564 BE.
//

import Foundation
import Kingfisher

import SwiftUI

struct MyListView: View {
    @State private var showBookDetail : Book? = nil
    @ObservedObject var viewModel = MyListViewModel()
    @ObservedObject var data = HomeViewModel()
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("My list")
                        .font(.custom("Lato-Bold", size: 32))
                        .foregroundColor(Color("MainColor"))
                    Spacer()
                }.padding()
                if !viewModel.isLoading{
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                        LazyVGrid(columns: columns,spacing:10,content: {
                            ForEach(viewModel.myList, id: \.name){book in
                                KFImage(book.URL)
                                    .resizable()
                                    .scaledToFill()
                                    .id(UUID())
                                    .onTapGesture {
                                        print(book)
                                        self.showBookDetail = book
                                    }
                            }
                        })
                    }).onAppear(perform: {
                        
                    })
                }
                Spacer()
            }
            if (showBookDetail != nil){
                BookDetailView(book: showBookDetail!, showBookDetail: $showBookDetail)
            }
        }.onAppear {
            data.fetchBookData()
            viewModel.getMyListData()
        }
        
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
