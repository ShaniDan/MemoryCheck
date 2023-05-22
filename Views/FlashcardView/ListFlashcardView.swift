//
//  ListFlashcardView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/29/23.

//  MARK: List of user question and answer flashcards
//  

import SwiftUI

struct ListFlashcardView: View {
    @State var savedFlashCards = LocalStorage.allFlashcardSets
    
    var body: some View {
        NavigationView {
            
            List(savedFlashCards, id: \.flashcardSetName) { cardSet in
                NavigationLink(destination: FlashcardView(set: cardSet)) {
                    Text(cardSet.flashcardSetName)
                        .font(.headline)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("My Flashcards")
        }.onAppear {
            savedFlashCards = LocalStorage.allFlashcardSets
        }
    }
}

struct ListFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        ListFlashcardView()
    }
}
// Text("Example")
