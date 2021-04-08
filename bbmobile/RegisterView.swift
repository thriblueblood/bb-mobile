//
//  RegisterView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 8/4/2564 BE.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    @Binding var show : Bool
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Color("MainColor")
                .edgesIgnoringSafeArea(.all)
                VStack{
                   
                    Text("Feel free to use our service!")
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
                    
                    TextField("Re-Enter Passwrod", text: self.$rePassword)
                        .padding(.all)
                        .font(.custom("Cocogoose Pro-trial", size: 16))
                        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white))
                        .padding(.top,20)
                    
                    Button(action: {
    //                    self.show.toggle()
                    }, label: {
                        Text("Register")
                            .font(.custom("Cocogoose", size: 16))
                            .foregroundColor(Color("MainColor"))
                            .padding(.all)
                            .frame(width: UIScreen.main.bounds.width-50)
                    })
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .padding(.top,20)

                }.padding(.horizontal,25).padding(.top,40)
            Button(action: {
                self.show.toggle()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("SecondaryColor"))
                    .font(.system(size: 24))
            }).padding(2)
        }.navigationBarHidden(true)
    }
}


//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
