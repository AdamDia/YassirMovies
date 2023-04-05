//
//  KingFisherImageView.swift
//  YassirMovies
//
//  Created by Adam Essam on 05/04/2023.
//

import SwiftUI
import Kingfisher

struct KingFisherImageView: View {
    let imageStrURL: String
    
    var body: some View {
        if let url = URL(string: imageStrURL) {
            KFImage(url)
                .resizable()
                .placeholder {
                    Image("MoviePlaceHolder")
                }
        }
    }
}
