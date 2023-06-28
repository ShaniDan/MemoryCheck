//
//  FirstView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/29/23.
//

import SwiftUI

struct FirstView: View {
    @State public var textField: String = ""
    @State var currentSet: UUID?
    var body: some View {
        NavigationView {
            VStack {
                Text("New set name")
                    .font(.headline)
                TextField("Title", text: $textField)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                
            }
            .padding()
        }
        .navigationBarItems(trailing:
                                Button {
            currentSet = LocalStorage.addSet(name: textField)
            textField = ""
        } label: {
            Text("Save")
        }
        )
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
