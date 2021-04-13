//
//  HomeView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import SwiftUI

struct HomeView: View {
    var viewModel = HomeViewModel()
    @State private var showBookDetail : Book? = nil
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView(showsIndicators:false) {
                //Main Vstack
                LazyVStack { //load only the view that user see for performance
                    TopTabBar()
                        
                
                    PreviewHomeView(book: examBook5)
                        .frame(width:UIScreen.main.bounds.width)
                        .padding(.top,-100)
                        .zIndex(-1)
                    HomeStackView(viewModel: viewModel, showBookDetail: $showBookDetail)
                }
            }
            
            if (showBookDetail != nil){
                BookDetailView(book: showBookDetail!,showBookDetail: $showBookDetail)
                    .animation(.easeIn)
                    .transition(.opacity)
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
            
        }.padding(.leading,20)
        .padding(.trailing,20)
    }
}


