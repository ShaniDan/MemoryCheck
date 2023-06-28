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
    
    // Gesture properties
    @State private var offset = CGSize.zero
    @State private var targetOffset = CGSize.zero
    
    init(set: FlashcardSet) {
        _set = State(initialValue: set)
    }
    
    // MARK: - Computed properties
    
    var currentCard: CardModel? {
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
                .frame(width: 330, height: 280)
                
            }
            .offset(x: offset.width)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }.onEnded { value in
                        withAnimation {
                            swipeCard(width: value.translation.width)
                            offset = .zero
                        }
                    }
            )
            
//            HStack {
//                Button("Previous Card", action: previousCard)
//                    .padding()
//                     Spacer()
//
//                Button("Next Card", action: nextCard)
//                    .padding()
//            }
//            NavigationLink (destination: TextEditorView(flashcardManager: FlashcardManager()), label: {
//                Text("Add Flashcard")
//                    .foregroundColor(.blue)
//            }
//            )
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement
                .navigationBarTrailing) {
                    NavigationLink(destination: EditCardsetView(set: set)) {
                        Text("Edit")
                    }
                }
        }
    }
    
    private func swipeCard(width: CGFloat) {
        let dragThreshold: CGFloat = 150
        
        if width < -dragThreshold {
            if currentIndex < set.flashCards.count - 1 {
                currentIndex += 1
                targetOffset = CGSize(width: -300, height: 0)
            }
        } else if width > dragThreshold {
            if currentIndex > 0 {
                currentIndex -= 1
                targetOffset = CGSize(width: 300, height: 0)
            }
        }
    }
    
    func nextCard() {
        currentIndex += 1
    }
    
    func previousCard() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}



struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(set: FlashcardSet(flashcardSetName: "Test"))
    }
}
