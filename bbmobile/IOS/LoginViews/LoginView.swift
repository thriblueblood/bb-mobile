//
//  LoginView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 6/4/2564 BE.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var goToHome : Bool = false
    @State var goToAdmin : Bool = false
    
    @State var goToRegister : Bool = false
    @State var alert = false
    @State var error = ""
    
    @State var email : String = ""
    @State var password : String = ""
    
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack{
            Color("MainColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("logo")
                Text("Thousand of books are await!")
                    .padding(.top,-35)
                    .font(.custom("Lato-Bold", size: 16))
                    .foregroundColor(Color("SecondaryColor"))
                
                TextField("Username", text: $email)
                    .padding(.all)
                    .font(.custom("Lato-Regular", size: 16))
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                    .padding(.top,20)
                
                SecureField("Password", text: $password)
                    .font(.custom("Lato-Regular", size: 16))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                    .padding(.top,20)
                
                Button(action: {
                    viewModel.login(email : email, password : password) {
//                    viewModel.checkUserType()
                        if email == "Kmitl@hotmail.com" && password == "123456"{
                            goToAdmin = true
                        }else{
                            goToHome = true
                        }
                    
                    }
                }, label: {
                    Text("Login")
                        .font(.custom("Lato-Black", size: 16))
                        .foregroundColor(Color("MainColor"))
                        .padding(.all)
                        .frame(width: UIScreen.main.bounds.width-50)
                })
                .background(Color("SecondaryColor"))
                .cornerRadius(10)
                .padding(.top,20)
                HStack {
                    Text("Don't have an acount?")
                        .font(.custom("Lato-Regular", size: 16))
                        .foregroundColor(Color("SecondaryColor"))
                    Button(action: {
                        goToRegister = true
                    }, label: {
                        Text("Register now")
                            .font(.custom("Lato-Bold", size: 16))
                            .foregroundColor(Color("SecondaryColor"))
                    })
                }
            }.padding(.horizontal,25)
            
//            if (viewModel.mode == .success && goToHome == true){
//                if viewModel.userType{
//                    AdminView(goToHome: $goToHome)
//                        .animation(.easeInOut)
//                        .transition(.opacity)
//                }else{
//                    ContentView(goToHome: $goToHome)
//                        .animation(.easeInOut)
//                        .transition(.opacity)
//                }
//            }
            
            if goToHome {
                ContentView(goToHome: $goToHome)
                    .animation(.easeInOut)
                    .transition(.opacity)
            }
            
            if goToAdmin{
                AdminView(goToAdmin: $goToAdmin)
                    .animation(.easeInOut)
                    .transition(.opacity)
            }
            
            if(goToRegister){
                RegisterView(goToRegister: $goToRegister)
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct ErrorView : View{
    @Binding var alert : Bool
    @Binding var error : String
    @State var color = Color.white.opacity(0.9)
    
    var body : some View{
        
        GeometryReader{_ in
            VStack{
                HStack{
                    Text("Error")
                        .font(.custom("Cocogoose", size: 16))
                        .foregroundColor(self.color)
                    Spacer()
                }
                .padding(.horizontal, 25)
                Text(self.error)
                    .foregroundColor(self.color)
                    .padding(.horizontal,25)
                    .padding(.top)
                
                
                Button(action: {
                    self.alert.toggle()
                }) {
                    Text("Cancel")
                        .font(.custom("Cocogoose", size: 16))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width-120)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .frame(width: UIScreen.main.bounds.width-70)
            .background(Color.black)
            .cornerRadius(15)
            
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
