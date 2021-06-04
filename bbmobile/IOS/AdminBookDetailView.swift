//
//  AdminBookDetailView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 3/6/2564 BE.
//

import SwiftUI
import Kingfisher

struct AdminBookDetailView: View {
    var book : Book
    @Binding var showBookDetail : Book?
    
    var genresList : String{
        var l : String = ""
        for i in book.category {
            l += "\(i), "
        }
        return l
    }
    
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
                            .padding(.bottom)
                    })
                    Spacer()
                    Button(action: {
                       
                    }, label: {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(Color("CustomWhite"))
                            .font(.system(size:32))
                            .padding(.trailing)
                            .padding(.bottom)
                    })
                }
                VStack{
                    HStack(alignment:.top){
                        Text("Cover:\t\t")
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(Color("MainColor"))
                        KFImage(book.URL)
                            .resizable()
                            .frame(width:UIScreen.main.bounds.width/3,height:UIScreen.main.bounds.height/4)
                            .padding(.bottom,4)
                        Spacer()
                        }
                    DetailStack(topic: "Title:\t\t", detail: book.name)
                    DetailStack(topic: "Author:\t", detail: book.author ?? "Unknown")
                    DetailStack(topic: "Genres:\t", detail: genresList)
                    DetailStack(topic: "Overview:", detail: book.overview ?? "Unknown")
                    HStack(alignment:.top){
                        Text("Content:\t")
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(Color("MainColor"))
                        Text("content.pdf")
                            .font(.custom("Lato-Regular", size: 18))
                            .foregroundColor(Color("CustomWhite"))
                        Spacer()
                        }
                }.padding(.leading)
             
                CustomButton(img: "trash.fill", text: "Delete this book")
                    .foregroundColor(Color("CustomWhite"))
                    .background(Color.red)
                    .padding(.top,5)
                    .padding(.horizontal)
                    .onTapGesture {
                        print(book.name+" has been deleted!")
                    }
                Spacer()
            }
        }
    }
}

struct AdminBookDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        AdminBookDetailView(book: examBook3, showBookDetail: .constant(nil))
    }
    
}

struct DetailStack: View {
    var topic : String
    var detail : String
    
    var body: some View {
        HStack(alignment:.top){
                Text(topic)
                    .font(.custom("Lato-Bold", size: 18))
                    .foregroundColor(Color("MainColor"))
        
                Text(detail)
                    .font(.custom("Lato-Regular", size: 18))
                    .foregroundColor(Color("CustomWhite"))
            Spacer()
        }
    }
}
