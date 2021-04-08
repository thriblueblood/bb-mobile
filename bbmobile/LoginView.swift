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
    @Binding var show: Bool
    
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
                    self.show.toggle()
                }, label: {
                    Text("Don't have an account?")
                        .font(.custom("Cocogoose", size: 16))
                        .foregroundColor(Color("SecondaryColor"))
                })
            }.padding(.horizontal,25)
        }.navigationBarHidden(true)
    }
        
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LoginView(show: true)
//            LoginView(show: false)
//               }
//    }
//}
