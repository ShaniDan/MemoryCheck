//
//  LocalStorage.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/19/23.


import Foundation

class LocalStorage {
    
    private static var myKey: String = "myKey"
    
    
    private static var cardSets: [FlashcardSet] = getSets() {
        didSet {
            save(cardSets)
        }
    }
    private static func save(_ sets: [FlashcardSet]) {
        if let data = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(data, forKey: myKey
    )
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
        print(cardSets)
        return cardSet.id
    }

    static func add(card: Card, to id: UUID?) {
        guard let id = id, let index = allFlashcardSets.firstIndex(where: { $0.id == id }) else { return }
        var cardSet = cardSets.remove(at: index)
        cardSet.flashCards.append(card)
        cardSets.insert(cardSet, at: index)
        cardSets.append(cardSet)
    }
    
    // MARK: Update function
    
    static func updateCardSet(id: UUID, newName: String) {
        guard let index = cardSets.firstIndex(where: { $0.id == id }) else {
            return
        }
        cardSets[index].flashcardSetName = newName
    }
    
    public static var allFlashcardSets: [FlashcardSet] {cardSets}
    
    
    // MARK: Delete function
    
    static func deleteCardSet(indexSet: IndexSet) {
        cardSets.remove(atOffsets: indexSet)
    }
}



struct Card : Codable, Identifiable, Hashable {
    var id = UUID()
    var question : String
    var answer : String
}

// A struct to store one FlashCard set's data
struct FlashcardSet : Codable, Identifiable, Hashable {
    var id = UUID()
    var flashcardSetName : String
    var flashCards : [Card] = []
}


