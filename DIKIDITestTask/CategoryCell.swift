//
//  CategoryCell.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 27.12.2022.
//

import SwiftUI

struct CategoryCell: View {
    @State var link: String
    @State var name: String
    @State var address: String
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: link))
                .frame(width: 100, height: 100, alignment: .leading)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            VStack {
                Text(name)
                Text(address)
            }
            .frame(width: 100, height: 100, alignment: .trailing)
            
        }
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(
            link: "https://f1.test.dikidi.ru/c1/v6/2h8auht407.jpg?size=f",
            name: "Hello",
            address: "World"
        )
    }
}


