//
//  CategoryTile.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 30.12.2022.
//

import SwiftUI

struct CategoryTile: View {
    @State var arrayOfCategories: [String]?
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(arrayOfCategories ?? [String](), id: \.self) { item in
                    CategoryCell(text: item)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 200)
    }
}

struct CategoryTile_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTile(arrayOfCategories: ["One","Two","Three","Four","Five"])
    }
}
