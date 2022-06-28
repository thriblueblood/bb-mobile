//
//  CustomTabSwitcher.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import SwiftUI
import Firebase
struct CustomTabSwitcher: View {
    
    @State private var currentTabIndex : BookTab = .more
    var tabs : [BookTab]
    var book : Book
    
    @ObservedObject var viewModel = BookDetailViewModel()
    @ObservedObject var data = HomeViewModel()

    
    func flexTabWidth(tabs : BookTab)-> CGFloat{
        let string = tabs.rawValue
        return string.widthOfString(usingFont: .systemFont(ofSize: 16))
        
    }
    var body: some View {
        if (!data.isLoading){
            VStack {
                HStack(spacing:10){
                    ForEach(tabs,id: \.self) { tab in
                        VStack{
                            Button(action: {
                                currentTabIndex = tab
                            }, label: {
                                Text(tab.rawValue)
                                    .foregroundColor( tab == currentTabIndex ? Color("CustomWhite"):Color("CustomBlack"))
                                    .font(.custom("Lato-Bold", size: 16))
                            })
                            Rectangle()
                                .foregroundColor( tab == currentTabIndex ? Color("MainColor"):Color("SecondaryColor"))
                                .frame(width:flexTabWidth(tabs: tab),height:5)
                        }

                      
                    }
                    Spacer()
                }
                
                switch currentTabIndex{                    
                case .more :
                        MoreLikeThis(book:viewModel.getMoreLikeThis(genres: book.category, data: data.bookData))
                }
            }.onAppear(perform: {
                data.fetchBookData()
    //            print(data.bookData)
            })
        }

    }
}

enum BookTab : String{
//    case content = "CONTENT"
    case more = "MORE LIKE THIS"
}

//struct CustomTabSwitcher_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack{
//            Color("SecondaryColor")
//                .edgesIgnoringSafeArea(.all)
//            CustomTabSwitcher(tabs: [BookTab.chapter,BookTab.more],book:examBook2)
//        }
//      
//    }
//}
