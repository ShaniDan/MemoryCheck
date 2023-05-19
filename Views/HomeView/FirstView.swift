//
//  FirstView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/29/23.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hey there!");
                    NavigationLink(destination: TextEditorView(), label: {Text("Create Flashcard")})
                }
            }
        }
    }

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
