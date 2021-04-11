//
//  PreviewHomeView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 10/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct PreviewHomeView: View {
    
    var book : Book
    
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
                HStack{
                    Spacer()
                    MyListButton(text: "My List", activeImg: "checkmark", inactiveImg: "plus", isActive: false)
                    CustomButton(img: "book", text: "Read now", textColor: "SecondaryColor", btnColor: "MainColor")
                        .frame(width:155)
                        .padding(.leading,10)
                    Spacer()
                }
            }.background(
                LinearGradient(gradient: Gradient(colors: [Color("SecondaryColor").opacity(0.0), Color("SecondaryColor").opacity(1.0)]), startPoint: .top, endPoint: .bottom).padding(.top,200)
            )

            
        }
        .foregroundColor(.white)
        .font(.custom("Cocogoose", size: 14))
    
    }
}

struct PreviewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHomeView(book: examBook1)
    }
}
