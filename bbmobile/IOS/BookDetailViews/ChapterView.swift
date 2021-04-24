//
//  ChapterView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct ChapterView: View {
    var book : Book
    var episode : [Episode]
    var body: some View {
        
            VStack{
                ForEach(book.pages, id: \.self){ pages in
                    KFImage(URL(string:pages))
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                        .padding(.bottom,2)
                }
        }
            
//        VStack{
//            ForEach(book.pages, id: \.self){ pages in
//                KFImage(URL(string:"https://firebasestorage.googleapis.com/v0/b/bb-mobile-2fa59.appspot.com/o/my_hero_277%231.png?alt=media&token=cd8f3de4-0e63-41bb-b221-ee2412f7a26f"))
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
//            KFImage(URL(string:"https://firebasestorage.googleapis.com/v0/b/bb-mobile-2fa59.appspot.com/o/my_hero_277%231.png?alt=media&token=cd8f3de4-0e63-41bb-b221-ee2412f7a26f"))
//                .resizable()
//                .scaledToFit()
//                .padding()
//            KFImage(URL(string:"https://firebasestorage.googleapis.com/v0/b/bb-mobile-2fa59.appspot.com/o/my_hero_277%231.png?alt=media&token=cd8f3de4-0e63-41bb-b221-ee2412f7a26f"))
//                .resizable()
//                .scaledToFit()
//                .padding()
                
//                    Text("\(pages)")
//            }
        
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
            ChapterView(book: examBook1, episode: [examEpisode1,examEpisode2])
        }
        
    }
}
