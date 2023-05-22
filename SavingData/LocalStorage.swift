//
//  LocalStorage.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/19/23.

/*
 - an object that encapsulates a card (question/answer)
 - [Card]
 - storage needs
    - to be able to add a card
    - to load all cards
 */

/* MARK: NEED TO LEARN
 - Codable
 - JSONEncoder, JSONDecoder, encode, decode
 - UserDefaults.standard.data
 - CRUD */

// import Foundation imports the Foundation framework, which provides fundamental programming interfaces and services for Apple platforms.

import Foundation


class LocalStorage {
    
// private static var myKey: String = "myKey" declares a private static property myKey that holds a string key used to identify the data stored in UserDefaults.
    
    private static var myKey: String = "myKey"
    private static var myKey2: String = "myKey2"
    
// private static var cards: [Card] {...} declares a private static computed property cards that provides access to the stored cards. When the cards property is set, it encodes the new value using JSONEncoder and stores the encoded data in UserDefaults using the myKey key. When the cards property is read, it retrieves the stored data from UserDefaults using the myKey key, decodes the data using JSONDecoder, and returns the decoded [Card] array.
    
    private static var cardSets: [FlashcardSet] {
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: myKey2)
            }
        }
        get {
            if let data = UserDefaults.standard.data(forKey: myKey2),
               let cardSet = try? JSONDecoder().decode([FlashcardSet].self, from: data) {
                return cardSet
        }
        return []
    }
}
    
    // CRUD
    // MARK: Create function
    
    static func addSet(name: String) -> UUID {
        let cardSet = FlashcardSet(flashcardSetName: name)
        cardSets.append(cardSet)
        return cardSet.id
    }
    // static func add(card: Card) is a static method of the LocalStorage class that adds a new Card object to the stored array of cards.

    static func add(card: Card, to id: UUID?) {
        
        guard let id = id, let index = allFlashcardSets.firstIndex(where: { $0.id == id }) else { return }
        var cardSet = cardSets.remove(at: index)
        cardSet.flashCards.append(card)
        cardSets.insert(cardSet, at: index)
        cardSets.append(cardSet)
    }
    
    // MARK: Update - need to make an update feature
    // MARK: update function to edit the text
    
    static func updateCardSet(id: UUID, newName: String) {
        guard let index = cardSets.firstIndex(where: { $0.id == id }) else {
            return
        }
        cardSets[index].flashcardSetName = newName
    }
    public static var allFlashcardSets: [FlashcardSet] {cardSets}
    
    
    // MARK: Delete
}


// struct Card: Codable {...} is a struct that defines a Card object with properties question, answer, and name. The Codable protocol is implemented to allow easy encoding and decoding of Card objects to and from JSON.

struct Card : Codable, Identifiable, Hashable {
    var id = UUID()
    let question : String
    let answer : String
}

// A struct to store one FlashCard set's data
struct FlashcardSet : Codable, Identifiable, Hashable {
    var id = UUID()
    var flashcardSetName : String
    var flashCards : [Card] = []
}


