//
//  AdminView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 1/6/2564 BE.
//

import SwiftUI
import Kingfisher
import FirebaseFirestore

struct AdminView: View {
    
    @State private var showBookDetail : Book? = nil
    @State private var showAddNewBook : Bool = false
    
    @ObservedObject var viewModel = AdminViewModel()
    
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //Top Section
                HStack{
                    Text("Hello, Admin")
                        .font(.custom("Lato-Bold", size: 34))
                        .foregroundColor(Color("MainColor"))
                    Spacer()
                    Button(action: {
                        showAddNewBook = true
                    }, label: {
                        Image(systemName:"doc.fill.badge.plus")
                        .font(.system(size: 28))
                            .foregroundColor(Color("MainColor"))
                    })
                }
                //SearchBar
                
                //Listview
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.books, id: \.id){ book in
                            AdminListView(book:book)
                                .onTapGesture(perform: {
                                    showBookDetail = book
                                })
                            Divider()
                                .background(Color("MainColor"))
                        }
                    }
                }.onAppear(perform: {
                    viewModel.fetchBookData()
                })
                    
            }
            if showBookDetail != nil {
                AdminBookDetailView(book: showBookDetail!, showBookDetail: $showBookDetail)
            }
            
            if showAddNewBook != false {
                AdminAddBookView(showAddNewBook: $showAddNewBook)
            }
    }
}
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView(viewModel: AdminViewModel())
    }
}

struct AdminListView: View {
    
    var book : Book
    
    var body: some View {
        HStack{
            KFImage(book.URL)
                .resizable()
                .frame(width:UIScreen.main.bounds.width/4,height:UIScreen.main.bounds.height/5.5)
            VStack(alignment:.leading){
                Text(book.name)
                    .font(.custom("Lato-Bold", size: 18))
                    .foregroundColor(Color("MainColor"))
                Text(book.author ?? "Unknown" )
                    .font(.custom("Lato-Regular", size: 18))
                    .foregroundColor(Color("CustomWhite"))
            }
            Spacer()
        }
    }
}
