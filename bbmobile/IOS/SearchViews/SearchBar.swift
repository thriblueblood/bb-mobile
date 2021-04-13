//
//  SearchBar.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 13/4/2564 BE.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text : String
    @State private var isEditing = true
    @Binding var isLoading : Bool
    
    var body: some View {
        ZStack(alignment:.leading) {
            Color("CustomBlack")
                .frame(width:270,height:36)
                .cornerRadius(8)
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("MainColor"))
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.leading,-7)
                    .background(Color("CustomBlack"))
                    .foregroundColor(Color("MainColor"))
                    .cornerRadius(5)
                    .onTapGesture {
                        isEditing = true
                    }
                
                if !text.isEmpty{
                    if isLoading {
                        Button(action: {
                            text=""
                        }, label: {
                            ActivityIndicator(style: .medium, animate: .constant(true))
                                .configure{
                                    $0.color = UIColor(Color("CustomWhite"))
                                }
                        }).padding(.trailing,22)
                    }else{
                        Button(action: {
                            text=""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("MainColor"))
                                .frame(width:35,height: 35)
                        }).padding(.trailing,20)
                    }
                }
                
                if isEditing{
                    Button(action: {
                        isEditing = false
                        text = ""
                        hideKeyboard()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color("MainColor"))
                            .font(.custom("Lato-Regular", size: 18))
                    })
                }
                
            }.padding(.horizontal)
        }
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            SearchBar(text: .constant(""), isLoading: .constant(false))
                .padding()
        }
        
    }
}
