//
//  WebVIew.swift
//  Hacker NEws
//
//  Created by ran you on 1/26/22.
//

import Foundation
import WebKit
import SwiftUI


struct WebView:UIViewRepresentable{
    let urlString:String?
    
    func makeUIView(context: Context) -> WKWebView{
      return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url=URL(string:safeString){
                let request=URLRequest(url:url)
                uiView.load(request)
            }
        }
    }
    
    
}
