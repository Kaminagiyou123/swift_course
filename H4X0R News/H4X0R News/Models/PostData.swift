//
//  PostData.swift
//  H4X0R News
//
//  Created by ran you on 1/25/22.
//

import Foundation

struct Results:Decodable{
    let hits:[Post]
    
}

struct Post: Decodable,Identifiable{
    let title:String
    let points:Int
    let url:String?
    let objectID: String
    var id:String{
        return objectID
    }
}
