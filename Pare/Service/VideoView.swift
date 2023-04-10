//
//  VideoView.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/10/23.
//

import SwiftUI
import WebKit

struct Video: UIViewRepresentable {

    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let ytURL = URL(string: "https://www.youtube.com/embed/\(videoID)")

        else {
            return
        }

        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: ytURL))
        
    }
}
