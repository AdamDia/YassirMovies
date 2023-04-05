//
//  TrailorView.swift
//  YassirMovies
//
//  Created by Adam Essam on 01/04/2023.
//

import SwiftUI
import SafariServices

struct TrailorView: View {
    var movieURL: URL?
    var body: some View {
        if let movieURL = movieURL {
            SafariView(url: movieURL)
        }
    }
}

struct TrailorView_Previews: PreviewProvider {
    static var previews: some View {
        TrailorView(movieURL: URL(string: "https://www.youtube.com/watch?v=\(mockTrailerData.first!.utubeTrailerKey)")!)
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        uiViewController.dismissButtonStyle = .close
    }
}
