//
//  EditCardsetView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 5/23/23.
//

import SwiftUI

struct EditCardsetView: View {
    @State var set: FlashcardSet
    @State var savedFlashCards: [CardModel] = []
    @State var currentName: UUID?
    @State var cardSetName: String = ""
    
    init(set: FlashcardSet) {
        _set = State(initialValue: set)
    }
    
    var body: some View {
        VStack {
            Text("Name")
                TextField("Enter Card Set Name", text: $cardSetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            List {
                ForEach(0..<savedFlashCards.count, id: \.self) { index in
                    Text(savedFlashCards[index].question)
                    Text(savedFlashCards[index].answer)
                }
//                .onDelete(perform: LocalStorage.deleteCard)
            }
        }
        .onAppear {
            cardSetName = set.flashcardSetName
            savedFlashCards = set.flashCards
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement
                .navigationBarTrailing) {
                    Button(action: {
                        if let updatedCardSetID = LocalStorage.updateCardSet(cardSetID: set.id, newName: cardSetName) {
                            currentName = updatedCardSetID
                        }
                        cardSetName = ""
                    }, label: {
                        Text("Save")
                    })
                }
        }
    }
}

struct EditCardsetView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsetView(set: FlashcardSet(flashcardSetName: "Test"))
    }
}

