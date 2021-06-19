//
//  BookDetailView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 11/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct BookDetailView: View {
    var book : Book
    @Binding var showBookDetail : Book?
    @ObservedObject var viewModelData = BookDetailViewModel()
    @ObservedObject var viewModel = MyListViewModel()
    @State var showContent : Bool = false
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        showBookDetail = nil
                    }, label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .foregroundColor(Color("MainColor"))
                            .font(.system(size:32))
                            .padding(.leading)
                    })
                    Spacer()
                }
                Spacer()
                
                //Content
                ScrollView(showsIndicators:false){
                    VStack{
                        TopBookInfoView(book:book)
                        CustomButton(img: "book.fill", text: viewModelData.userStatus ? "Read now" : "Subscribe to read the book")
                            .foregroundColor(Color(viewModelData.userStatus ? "SecondaryColor" : "CustomBlack"))
                            .background(Color(viewModelData.userStatus ? "MainColor" : "CustomWhite"))
                            .padding(.top,5)
                            .onTapGesture {
                                viewModelData.userStatus ?
                                    showContent = true : print("Please, subscribe")
                            }.onAppear(perform: {
                                viewModelData.getUserData()
                            })
                        CustomButton(img: "bookmark.fill", text: viewModel.isMyList ? "Delte to my list":"Add to my list")
                            .foregroundColor(Color("CustomWhite"))
                            .background(Color("CustomBlack"))
                            .onTapGesture {
                                viewModel.switchMyList(title: book.name)
                            }
                        CustomTabSwitcher(tabs: [BookTab.more],book: book)

                    }.padding(.horizontal,5)
                }
            }
            
            if showContent {
                ReadView(showContent: $showContent, url: book.content!)
            }
        }
    }
}

struct TopBookInfoView: View {
    var book : Book
    
    var genresList : String{
        var l : String = ""
        for i in book.category {
            l += "\(i), "
        }
        return l
    }
    
    var body: some View {
        VStack{
            KFImage(book.URL)
                .resizable()
                .frame(width:UIScreen.main.bounds.width/2,height:UIScreen.main.bounds.height/3)
                .padding(.bottom,4)
            HStack{
                VStack(alignment:.leading){
                    Text(book.name)
                        .foregroundColor(Color("MainColor"))
                        .font(.custom("Lato-black", size: 24))
                        .padding(.bottom,2)
                    Text("Genres: \(genresList)")
                    Text("Author: \(book.author ?? "")")
                    Text("Overview: \(book.overview ?? "")")
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
                .font(.custom("Lato-Bold", size: 16))
                Spacer()
            }

        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: examBook3, showBookDetail: .constant(nil))
    }
}


