//
//  InfoView.swift
//  RanCard
//
//  Created by ran you on 1/24/22.
//

import SwiftUI

struct InfoView: View {
    let text:String
    let imageName:String
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.white)
            .frame(height: 50, alignment: .center)
            .overlay(
                HStack {
                    Image(systemName: imageName).foregroundColor(.green)
                    Text(text)
                        .foregroundColor(.black)
                }
            ).padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView  (text:"+1 4342276459", imageName:"phone.fill").previewLayout(.sizeThatFits)
    }
}
