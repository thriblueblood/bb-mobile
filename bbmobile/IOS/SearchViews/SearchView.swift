//
//  SearchView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 13/4/2564 BE.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State private var text : String = ""
    @State private var showBookDetail : Book? = nil
    
    var body: some View {
        
        let searchTextBinding = Binding{
            return text
        } set:{
            text = $0 // $0 is the changes made / save value to the text
            viewModel.updateSearchText(string: $0)
        }
        
        return ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                SearchBar(text: searchTextBinding, isLoading: $viewModel.isLoading)
                    .padding()
                
                if viewModel.isShowExplore {
                    Spacer()
                    HStack{
                        Image(systemName: "globe")
                        Text("Explore your book")
                            .font(.custom("Lato-Bold", size: 24))
                    }.foregroundColor(Color("CustomBlack"))
                }
                
                if viewModel.viewState == .empty{
                    Text("There is no result for \(text)")
                        .foregroundColor(Color("CustomWhite"))
                        .font(.custom("Lato-Black", size: 24))
                }else if viewModel.viewState == .ready && !viewModel.isShowExplore{
                    VStack {
                        HStack{
                            Text("Search result: \(text)")
                                .foregroundColor(Color("CustomWhite"))
                                .font(.custom("Lato-Black", size: 24))
                                .padding(.leading)
                            Spacer()
                        }
                        SearchResultView(books: viewModel.searchResult, showBookDetail: $showBookDetail)
                    }
                    
                }
                Spacer()
            }
            if (showBookDetail != nil){
                BookDetailView(book: showBookDetail!, showBookDetail: $showBookDetail)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}





