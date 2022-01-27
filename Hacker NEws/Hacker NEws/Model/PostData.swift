//
//  ResultData.swift
//  Hacker NEws
//
//  Created by ran you on 1/26/22.
//

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
