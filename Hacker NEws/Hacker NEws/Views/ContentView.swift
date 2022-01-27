//
//  ContentView.swift
//  Hacker NEws
//
//  Created by ran you on 1/26/22.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var networkManager=NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){
                post in
                NavigationLink(destination: DetailView(url:post.url)) {
                    HStack{
                    Text(String(post.points))
                    Text(post.title)
                    }
                }
               
            }
            
        .navigationBarTitle("HAX0R NEWS")
        }.navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


