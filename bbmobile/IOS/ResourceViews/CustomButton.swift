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
    
    var body: some View {
            HStack{
                Spacer()
                Image(systemName: img)
                Text(text)
                    .font(.custom("Cocogoose", size: 16))
                Spacer()
            }
            .padding(.all,10)
            .cornerRadius(7)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(img: "book", text: "Read now")
            .foregroundColor(Color("SecondaryColor"))
            .background(Color("MainColor"))
    }
}
