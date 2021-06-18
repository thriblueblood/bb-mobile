//
//  LoadingView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 18/6/2564 BE.
//

import SwiftUI

struct LoadingView: View {
    
    let loadingState : LoadingState
    
    var body: some View {
        switch loadingState {
        case .loading:
            ProgressView("Loading....")
                .frame(maxWidth: .infinity, maxHeight: 100)
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: Color("CustomBlack")))
                .foregroundColor(Color("CustomBlack"))
                .background(Color("MainColor"))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .padding()
        case .idle,.failure,.success:
            EmptyView()
        }
    }
    
    struct LoadingView_Previews: PreviewProvider {
        static var previews: some View {
            LoadingView(loadingState: .loading)
        }
    }
}
