//
//  CategoryCell.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 30.12.2022.
//

import SwiftUI

struct CategoryCell: View {
    @State var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: 100, height: 60, alignment: .center)
                .foregroundColor(Color.blue)
            Text(text)
        }
    }
}
/*
struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(text: "Category")
    }
}
*/
