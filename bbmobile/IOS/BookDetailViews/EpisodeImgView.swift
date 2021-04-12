//
//  EpisodeImgView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 12/4/2564 BE.
//

import SwiftUI
import Kingfisher

struct EpisodeImgView: View {
    var imageURL : URL
    
    var body: some View {
        ZStack{
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct EpisodeImgView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeImgView(imageURL: examEpisode1.Image)
    }
}
