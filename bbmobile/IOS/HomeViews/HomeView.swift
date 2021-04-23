//
//  HomeView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 9/4/2564 BE.
//

import SwiftUI
import Firebase

struct HomeView: View {
    var viewModel = HomeViewModel()
    @State private var showBookDetail : Book? = nil
    @State private var showAccountView : Bool = false
    @Binding var goToHome : Bool
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators:false) {
                //Main Vstack
                LazyVStack { //load only the view that user see for performance
                    TopTabBar(showAccountView: $showAccountView)
                    
                    PreviewHomeView(book: examBook3, showBookDetail: $showBookDetail)
                        .frame(width:UIScreen.main.bounds.width)
                        .padding(.top,-100)
                        .zIndex(-1)
                    HomeStackView(viewModel: viewModel, showBookDetail: $showBookDetail)
                }
            }
            
            
            if (showBookDetail != nil){
                BookDetailView(book: showBookDetail!,showBookDetail: $showBookDetail)
//                    .animation(.easeIn)
//                    .transition(.opacity)
            }
            
            if(showAccountView){
                AccountView(showAccountView: $showAccountView, goToHome: $goToHome)
            }
        }
        .foregroundColor(.white)
        //        .font(.custom("Cocogoose", size: 16))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(goToHome: .constant(true))
    }
}

struct TopTabBar: View {
    @Binding var showAccountView : Bool
    var body: some View {
        HStack{
            Button(action: {
                showAccountView = true
            }, label: {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:50)
            })
            
            Spacer()
            Button(action: {
                showAccountView = true
            }, label: {
                Circle()
                    .frame(width:50)
            })
            
            
        }.padding(.leading,20)
        .padding(.trailing,20)
    }
}




