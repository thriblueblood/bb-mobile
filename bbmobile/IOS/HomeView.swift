//
//  HomeView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import SwiftUI

struct HomeView: View {
    var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView(showsIndicators:false) {
                //Main Vstack
                LazyVStack { //load only the view that user see for performance
                    TopTabBar()
                        .background(Color("MainColor"))
                
                    PreviewHomeView(book: examBook5)
                        .frame(width:UIScreen.main.bounds.width)
                        .padding(.top,-100)
                        .zIndex(-1)
                    
                    ForEach(viewModel.allCategories, id:\.self) { category in
                        VStack{
                            HStack{
                                Text(category)
                                    .padding(.leading,0)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHStack{
                                    ForEach(viewModel.getBook(forCategories: category)) { book in
                                        EachBookHomeView(book: book)
                                            .frame(width:100, height:200)
                                            .padding(.horizontal,20)
                                    }
                                }
                            }
                            .padding(.top,-5)
                        }.font(.custom("Cocogoose", size: 16))
                      
                
                    }
                }
            }
        }
        .foregroundColor(.white)
//        .font(.custom("Cocogoose", size: 16))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TopTabBar: View {
    var body: some View {
        HStack{
            Button(action: {

            }, label: {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:50)
            })
            
            Spacer()
            Text("Profile")
            
        }.background(Color("MainColor")).padding(.leading,20)
        .padding(.trailing,20)
    }
}
