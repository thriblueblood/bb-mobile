//
//  AccountView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 21/4/2564 BE.
//

import SwiftUI

struct AccountView: View {
    @Binding var showAccountView : Bool
    @Binding var goToHome : Bool
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        showAccountView = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color("MainColor"))
                    })

                    Spacer()
                }.padding(.leading)
                .font(.system(size: 36))
                HStack{
                    Button(action: {
                        goToHome = false
                    }, label: {
                        HStack{
                            Spacer()
                            Image(systemName: "person.fill.xmark")
                            Text("Logout")
                            Spacer()
                        }
                    })
                    .padding()
                    .font(.custom("Lato-Bold", size: 24))
                    .foregroundColor(Color("MainColor"))
                    .background(Color("CustomBlack"))
                    .padding(.leading,5)
                    Spacer()
                }
            Spacer()
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(showAccountView: .constant(true), goToHome: .constant(true))
    }
}
