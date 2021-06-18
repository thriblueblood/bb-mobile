//
//  CustomButtonView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 10/4/2564 BE.
//

import SwiftUI

struct MyListButton: View {
    var text : String
    
    @Binding var book : Book
    @ObservedObject var viewModel = MyListViewModel()

    
    var body: some View {
        Button(action: {
            viewModel.switchMyList(title: book.name)
//            let group = DispatchGroup()
//            group.enter()
//            viewModel.addToMyList(bookname: book.name)
//            group.leave()
//            group.notify(queue: DispatchQueue.global(qos: .background)){
//                viewModel.getMyListData()
//                }
            
        }, label: {
            VStack{
                Image(systemName: viewModel.isMyList ? "checkmark":"plus")
                .foregroundColor(Color("MainColor"))
                .font(.system(size: 24))
            Text(text)
                .font(.custom("Cocogoose", size: 12))
                .foregroundColor(.white)
            }
        
        }).onAppear(perform: {
            viewModel.getMyListData()
            viewModel.checkIsMyList(title: book.name)
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
