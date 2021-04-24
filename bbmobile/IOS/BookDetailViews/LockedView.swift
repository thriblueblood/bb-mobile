//
//  EpisodeImgView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct LockedView: View {

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "exclamationmark.circle.fill")
                    Text("Please Subscribe to see the content")
                }.foregroundColor(Color("MainColor"))
                .font(.custom("Lato-Bold", size: 18)).padding(.horizontal)
                Spacer()

            }

        }
    }
}

struct LockedView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            LockedView()
        }

    }
}
