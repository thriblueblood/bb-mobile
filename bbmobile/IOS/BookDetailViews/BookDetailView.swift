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
                        CustomTabSwitcher(tabs: [BookTab.content,BookTab.more],book: book)
                        
                    }.padding(.horizontal,5)
                }
            }
        }
    }
}

struct TopBookInfoView: View {
    var book : Book
//    @ObservedObject var viewModel = MyListViewModel()
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
                .foregroundColor(.white)
                .font(.custom("Lato-Bold", size: 16))
                Spacer()
            }
            CustomButton(img: "book.fill", text: "Read now")
                .foregroundColor(Color("SecondaryColor"))
                .background(Color("MainColor"))
                .padding(.top,5)
                .onTapGesture {
                    print(book.URL)
                }
            CustomButton(img: "bookmark.fill", text: "Add to my list")
                .foregroundColor(Color("CustomWhite"))
                .background(Color("CustomBlack"))
                .onTapGesture {
//                    viewModel.addToMyList(bookname: book.name)
//                    viewModel.getMyListData()
                }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: examBook3, showBookDetail: .constant(nil))
    }
}


