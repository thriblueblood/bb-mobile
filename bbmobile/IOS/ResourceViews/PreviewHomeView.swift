//
//  PreviewHomeView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 10/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct PreviewHomeView: View {
    
    @State var book : Book
    @Binding var showBookDetail:Book?
    
    public func isCateLast(cate : String)-> Bool {
        let count = book.category.count
        
        if let index = book.category.firstIndex(of: cate){
            if (index+1 != count){ //Check the index of array
                return false
            }
        }
        return true
    }
    
    
    var body: some View {
        ZStack{
            KFImage(book.URL)
                .resizable()
                .scaledToFill()
                .clipped()
            VStack{
                HStack{
                    Spacer()
                    ForEach(book.category, id: \.self) {category in
                        Text(category)
                            .foregroundColor(.white)
                        if !isCateLast(cate: category){
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(Color("MainColor"))
                                .font(.system(size: 12))
                        }
                    }
                    Spacer()
                }.background(Color("SecondaryColor"))
                .padding(.top,100)
                Spacer()
                VStack {
                    KFImage(book.URL)
                        .resizable()
                        .scaledToFit()
                        .frame(width:200)
                        .padding(.bottom,100)
                    HStack{
                        Spacer()
                        MyListButton(text: "My List", book: $book)
                        Button(action: {
                            showBookDetail = book
                        }, label: {
                            CustomButton(img: "book", text: "Read now")
                                .background(Color("MainColor"))
                                .foregroundColor(Color("SecondaryColor"))
                                .frame(width:155)
                                .padding(.leading,10)
                        })
                            
                        Spacer()
                    }.padding(.top,-70)
                }
            }.background(
                LinearGradient(gradient: Gradient(colors: [Color("SecondaryColor").opacity(0.0), Color("SecondaryColor").opacity(1.0)]), startPoint: .top, endPoint: .bottom)
            )

            
        }
        .foregroundColor(.white)
        .font(.custom("Cocogoose", size: 14))
    
    }
}

struct PreviewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHomeView(book: examBook4, showBookDetail: .constant(examBook3))
    }
}
