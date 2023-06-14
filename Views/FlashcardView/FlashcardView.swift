//
//  FlashcardView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/19/23.
//

import SwiftUI

struct FlashcardView: View {
    // @State property wrappers to store values for flipped, currentIndex and cards
    @State var flipped = false
    @State var currentIndex: Int = 0
    @State var set: FlashcardSet
    @State private var isShowingUpdateView = false
    
    init(set: FlashcardSet) {
        _set = State(initialValue: set)
    }
    
    // MARK: 
    var currentCard: Card? {
        if currentIndex < set.flashCards.count {
            return set.flashCards[currentIndex]
        } else {
            return nil
        }
    }
    
    var body: some View {
        VStack {
            Text(set.flashcardSetName)
            ZStack {
                Rectangle()
                    .fill(flipped ? Color.blue : Color(.systemIndigo))
                    .frame(width: 350, height: 300)
                    .cornerRadius(15)
                    .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .onTapGesture {
                        withAnimation { self.flipped.toggle()
                        }
                    }
                // MARK: Showing the text that is saved in the TextEditors
                
                VStack {
                    if let card = currentCard {
                        Text(flipped ? card.answer : card.question)
                    } else {
                        Text("No cards left")
                    }
                }
                .padding()
                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 0.0, z: 0.0)
                )
                .frame(width: 200, height: 100)
            }
            //            NavigationView {
            HStack {
                Button("Next Card", action: nextCard)
                    .padding()
                Spacer()
                
                NavigationLink(destination: EditCardsetView()) {
                    Text("Edit")
                }
                .padding()
            }
//            }
        }
    }
    
    private func nextCard() {
        currentIndex += 1
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(set: FlashcardSet(flashcardSetName: "Test"))
    }
}
