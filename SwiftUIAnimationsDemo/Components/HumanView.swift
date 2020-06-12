//
//  HumanView.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 12/06/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct Human: Codable {
    var name: String
    var image: String?
}

extension Human: Hashable, Identifiable {
    var id: String {
        self.name
    }
}

struct HumanView: View {
    var human: Human
    var body: some View {
        VStack {
            Image(self.human.image ?? "\(self.human.name.lowercased())-small")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .grayscale(0.4)
                .shadow(radius: 4)

            Text(self.human.name)
        }
    }
}

struct HumanView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HumanView(human: Human(name: "Kaio"))
            HumanView(human: Human(name: "Kaio"))
            HumanView(human: Human(name: "Kaio"))
        }
        .padding()
    }
}
