//
//  CustomButton.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 10/4/2564 BE.
//

import SwiftUI

struct CustomButton: View {
    var img : String
    var text : String
    var textColor : String
    var btnColor : String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack{
                Spacer()
                Image(systemName: img)
                    
                
                Text(text)
                    .font(.custom("Cocogoose", size: 16))
                Spacer()
            }
            .padding(.all,10)
            .foregroundColor(Color(textColor))
            .background(Color(btnColor))
            .cornerRadius(7)
            
          
        })
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(img: "book", text: "Read now", textColor: "SecondaryColor", btnColor: "MainColor")
    }
}
