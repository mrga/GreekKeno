//
//  LiveDrawView.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI
import WebKit

struct LiveDrawView: UIViewRepresentable {
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        webView.allowsLinkPreview = true
        
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: Endpoints.WebAPI.liveDraw)!))
    }
}


