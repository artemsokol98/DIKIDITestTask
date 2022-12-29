//
//  VIPCell.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 29.12.2022.
//

import SwiftUI

struct VIPCell: View {
    @State var link: String?
    @State var text: String?
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: link ?? "Unknown"))
                .frame(width: 50, height: 50, alignment: .leading)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            Text(text ?? "Unknown")
            Button("Записаться") {
                print("button pressed")
            }
        }
    }
}

struct VIPCell_Previews: PreviewProvider {
    static var previews: some View {
        VIPCell()
    }
}
