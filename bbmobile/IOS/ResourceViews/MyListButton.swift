//
//  CustomButtonView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 10/4/2564 BE.
//

import SwiftUI

struct MyListButton: View {
    var text : String
    
    var book : Book
    @ObservedObject var viewModel = MyListViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.isLoading{
                Button(action: {
                    viewModel.switchMyList(title: book.name)
                }, label: {
                    VStack{
                        Image(systemName: viewModel.isMyList ? "checkmark":"plus")
                            .foregroundColor(Color("MainColor"))
                            .font(.system(size: 24))
                        Text(text)
                            .font(.custom("Cocogoose", size: 12))
                            .foregroundColor(.white)
                    }
                    
                })
            }
            
        }.onAppear(perform: {
            viewModel.fetchMyList(title: book.name)
        })
    }
}



//
//struct MyListButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack{
//        Color(.black)
//            MyListButton(text: "My List", activeImg: "checkmark", inactiveImg: "plus", isActive: false, book: examBook1)
//        }
//    }
//}
