//
//  WebPreview.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import UIKit
import SwiftUI
import WebKit

let schemes = [
    "https://",
    "http://",
    "https://www",
    "http://www",
    "file://",
    "ftp://",
    "news:",
    "telnet://"
]


struct WebPreview: View {
    let domain: String
    
    var body: some View {
        WebPreviewImage(domain: domain)
            .frame(height: 300.0)
    }
}

struct WebPreviewImage: UIViewRepresentable {
    
    var domain: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        for scheme in schemes {
            if let url = URL(string: scheme + domain) {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    webView.load(request)
                }
                return
            } else if let url = URL(string: scheme + "." + domain) {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    webView.load(request)
                }
                return
            }
        }
    }
    
    private func makeRequest(_ webView: WKWebView, context: Context)  {
    }
    
    static func dismantleUIView(_ uiView: WKWebView, coordinator: ()) {
        uiView.closeAllMediaPresentations {
            print("Dismantled")
        }
    }
}

struct WebPreview_Previews: PreviewProvider {
    static var previews: some View {
        WebPreview(domain: "google.com")
    }
}
