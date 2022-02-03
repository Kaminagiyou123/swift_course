//
//  DetailView.swift
//  Hacker News
//
//  Created by ran you on 2/2/22.
//

import SwiftUI
import WebKit
struct DetailView: View {
    let url:String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://google.com")
    }
}

