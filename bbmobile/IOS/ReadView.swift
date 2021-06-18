//
//  ReadView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 17/6/2564 BE.
//

import SwiftUI

struct ReadView: View {
    @Binding var showContent : Bool
    var url : URL
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        showContent = false
                    }, label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .foregroundColor(Color("MainColor"))
                            .font(.system(size:32))
                            .padding(.leading)
                    })
                 
                    Text("BB Mobile")
                        .foregroundColor(Color("MainColor"))
                        .font(.custom("Lato-Bold", size: 16))
                    
                    Spacer()
                }
                PDFKitView(url: url)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }

    }
}

struct ReadView_Previews: PreviewProvider {
    static var previews: some View {
        ReadView(showContent: .constant(true), url: URL(string: "https://firebasestorage.googleapis.com/v0/b/bb-mobile-2fa59.appspot.com/o/examPdf.pdf?alt=media&token=6bce7931-c4a8-4c7e-9c00-b25c0462b760" )!)
    }
}
