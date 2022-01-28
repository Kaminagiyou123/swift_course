//
//  ContentView.swift
//  HACKERNEWS
//
//  Created by ran you on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager=NetworkManager()
    
    var body: some View {

        NavigationView {
            
            List(networkManager.posts){
                post in
                NavigationLink(destination: DetailView(url:post.url)) {
                    HStack{
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
                
            }
            .navigationBarTitle("HACKER NEWS")
        }.navigationViewStyle(StackNavigationViewStyle())
            . onAppear {
                self.networkManager.fetchData()
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



