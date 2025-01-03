//
//  WebView.swift
//  StikEMU
//
//  Created by Stephen on 10/11/24.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.configuration.preferences.javaScriptEnabled = true
        webView.scrollView.isScrollEnabled = false // Disable scrolling
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url != url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Erreur de chargement : \(error.localizedDescription)")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Chargement terminé")
        }
    }
}
