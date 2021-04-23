//
//  ChapterView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct ChapterView: View {
    var episode : [Episode]
    var body: some View {
        VStack{
            KFImage(URL(string: "https://firebasestorage.googleapis.com/v0/b/bb-mobile-2fa59.appspot.com/o/my_hero_277%233.png?alt=media&token=ee891ced-6304-40c9-acdc-988aa7e37e1b")!)
                .resizable()
                .scaledToFit()
                .padding()
        }
//        HStack {
//            VStack(alignment:.leading) {
//                    ForEach(episode) { e in
//                        Button(action: {
//
//                        }, label: {
//                            VStack(alignment:.leading){
//                                HStack{
//                                    EpisodeImgView(imageURL: e.Image)
//                                        .frame(width:150,height:100)
//                                        .clipped()
//                                    VStack{
//                                        Text(e.name)
//                                            .foregroundColor(Color("CustomWhite"))
//                                            .font(.custom("Lato-Bold", size: 16))
//                                    }
//                                }
//
//                            }
//                        })
//
//                    }
//                    Spacer()
//            }
//            Spacer()
//        }

    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            ChapterView(episode: [examEpisode1,examEpisode2])
        }
        
    }
}
