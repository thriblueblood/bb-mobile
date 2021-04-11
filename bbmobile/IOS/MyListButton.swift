//
//  CustomButtonView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 10/4/2564 BE.
//

import SwiftUI

struct MyListButton: View {
    var text : String
    
    var activeImg : String
    var inactiveImg : String
    var isActive : Bool
    
    var img : String {
        if isActive{
            return activeImg
        }else{
            return inactiveImg
        }
    }
    
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack{
            Image(systemName: img)
                .foregroundColor(Color("MainColor"))
                .font(.system(size: 24))
            Text(text)
                .font(.custom("Cocogoose", size: 12))
                .foregroundColor(.white)
            }
        
        })
    }
}

struct MyListButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
        Color(.black)
        MyListButton(text: "My List", activeImg: "checkmark", inactiveImg: "plus", isActive: false)
        }
    }
}
