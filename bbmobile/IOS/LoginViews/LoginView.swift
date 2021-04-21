//
//  LoginView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 6/4/2564 BE.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var goToHome : Bool = false
    @State var goToRegister : Bool = false
    
    var body: some View {
        
        ZStack{
            Color("MainColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                    Image("logo")
                    Text("Thousand of books are await!")
                        .padding(.top,-35)
                        .font(.custom("Cocogoose", size: 16))
                        .foregroundColor(Color("SecondaryColor"))
                    
                TextField("Username", text: self.$email)
                    .padding(.all)
                    .font(.custom("Cocogoose Pro-trial", size: 16))
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                    .padding(.top,20)
                
                TextField("Password", text: self.$password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                    .padding(.top,20)
                
                Button(action: {
                    goToHome = true
                }, label: {
                    Text("Login")
                        .font(.custom("Cocogoose", size: 16))
                        .foregroundColor(Color("MainColor"))
                        .padding(.all)
                        .frame(width: UIScreen.main.bounds.width-50)
                })
                .background(Color("SecondaryColor"))
                .cornerRadius(10)
                .padding(.top,20)
                
                Button(action: {
                    goToRegister = true
                }, label: {
                    Text("Don't have an account?")
                        .font(.custom("Cocogoose", size: 16))
                        .foregroundColor(Color("SecondaryColor"))
                })
            }.padding(.horizontal,25)
            
            if(goToHome){
                ContentView(goToHome: $goToHome)
                    
                    .animation(.easeInOut)
                    .transition(.opacity)
            }
            if(goToRegister){
                RegisterView(goToRegister: $goToRegister)
            }
        }
        
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
