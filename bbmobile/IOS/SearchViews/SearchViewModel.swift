//
//  SearchViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 13/4/2564 BE.
//

import Foundation

class SearchViewModel : ObservableObject {
    @Published var isLoading : Bool = false
    @Published var viewState: ViewState = .ready
    @Published var searchResult : [Book] = []
    @Published var isShowExplore : Bool = true
    
    public func updateSearchText(string:String){
        setState(state: .loading)
        getSearchResult(string: string)
        
        if string.count > 0 {
            isShowExplore = false
            getSearchResult(string: string)
        }
        else{
            isShowExplore=true
        }
    }
    
    private func getSearchResult(string : String){
        let haveResult = Int.random(in:0...3)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            if haveResult == 0 {
                self.searchResult = []
                self.setState(state: .empty)
            }else{
                let books = generateBooks(20)
                self.searchResult = books
                self.setState(state: .ready)
            }
        }
    }
    
    private func setState(state:ViewState){
        DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading //if state is equal loading then isLoading = true
        }
    }
}

enum ViewState{
    case empty
    case loading
    case ready
    case error
}
