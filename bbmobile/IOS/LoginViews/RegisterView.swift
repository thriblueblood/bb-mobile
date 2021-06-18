//
//  RegisterView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 8/4/2564 BE.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @Binding var goToRegister : Bool
    @ObservedObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Color("MainColor")
                .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Feel free to use our service!")
                        .font(.custom("Lato-Bold", size: 16))
                        .foregroundColor(Color("SecondaryColor"))
                    
                    TextField("Username", text: $email)
                        .padding(.all)
                        .font(.custom("Lato-Regular", size: 16))
                        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                        .padding(.top,20)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .font(.custom("Lato-Regular", size: 16))
                        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                        .padding(.top,20)
                    
//                    SecureField("Re-Enter Passwrod", text: $viewModel.confirmPassword)
//                        .padding(.all)
//                        .font(.custom("Lato-Regular", size: 16))
//                        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
//                        .padding(.top,20)
                    
                    Button(action: {
                        viewModel.register(email: email, password: password)
                       goToRegister = false
                    }, label: {
                        Text("Register")
                            .font(.custom("Lato-Black", size: 16))
                            .foregroundColor(Color("MainColor"))
                            .padding(.all)
                            .frame(width: UIScreen.main.bounds.width-50)
                    })
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .padding(.top,20)

                }.padding(.horizontal,25).padding(.top,40)
            Button(action: {
                goToRegister = false
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("SecondaryColor"))
                    .font(.system(size: 24))
            }).padding(2).padding(.leading)
        }.navigationBarHidden(true)
    }    
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(goToRegister: .constant(true))
    }
}
