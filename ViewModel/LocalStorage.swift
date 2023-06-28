//
//  LocalStorage.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/19/23.


import Foundation
import SwiftUI

class LocalStorage {
    
    private static var myKey: String = "myKey"
    
    
    private static var cardSets: [FlashcardSet] = getSets() {
        didSet {
            save(cardSets)
            print("Card sets updated: \(cardSets)")
        }
    }
    private static func save(_ sets: [FlashcardSet]) {
        if let data = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(data, forKey: myKey
    )
            print("Card sets saved to UserDefaults")
        }
    }
    
    private static func getSets() -> [FlashcardSet] {
        if let data = UserDefaults.standard.data(forKey: myKey),
           let cardSet = try? JSONDecoder().decode([FlashcardSet].self, from: data) {
            return cardSet
        }
        return []
    }
    
    // MARK: CRUD
    // MARK: Create function
    
    static func addSet(name: String) -> UUID {
        let cardSet = FlashcardSet(flashcardSetName: name)
        cardSets.append(cardSet)
        print("New card set added: \(cardSet)")
        return cardSet.id
    }

    static func add(card: CardModel, to id: UUID?) {
        guard let id = id, let index = allFlashcardSets.firstIndex(where: { $0.id == id }) else { return }
        var cardSet = cardSets.remove(at: index)
        cardSet.flashCards.append(card)
        cardSets.insert(cardSet, at: index)
        print("New card added to card set: \(card)")
    }
    
    // MARK: Update function

        static func updateCardSet(cardSetID: UUID, newName: String) -> UUID? {
            guard let cardSetIndex = cardSets.firstIndex(where: { $0.id == cardSetID }) else {
                return nil
            }

            cardSets[cardSetIndex].flashcardSetName = newName
            return cardSets[cardSetIndex].id
        }

    // MARK: Why do I need this line of code
    
    public static var allFlashcardSets: [FlashcardSet] {cardSets}
    
    
    // MARK: Delete function
    
    static func deleteCardSet(indexSet: IndexSet) {
        cardSets.remove(atOffsets: indexSet)
    }
        
        // MARK: Delete function for individual cards
        
}

class FlashcardManager: ObservableObject {
    @Published var allFlashcardSets: [FlashcardSet] = []
}
