//
//  MyListView.swift
//  bbmobile
//
//  Created by Sathienpong Polachan on 26/4/2564 BE.
//

import Foundation

import SwiftUI

struct MyListView: View {
    var books : [Book]
    @State private var showBookDetail : Book? = nil
    @ObservedObject var viewModel = MyListViewModel()
    
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
                
                Button(action: {
                    print(viewModel.isLoaded)
                }, label: {
                    Text("Check loading...")
                        .foregroundColor(.white)
                })
                
                if viewModel.isLoaded{
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                        LazyVGrid(columns: columns,spacing:10,content: {
                            ForEach(viewModel.myList, id: \.id){book in
                                EachBookHomeView(book: book)
                                    .onTapGesture {
                                     
                                        self.showBookDetail = book
                                    }
                            }
                        })
                    })
                }
                Spacer()
            }
        }
        
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView(books: examBooks)
    }
}
