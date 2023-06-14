//
//  TextEditorView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/19/23.
//

import SwiftUI

struct TextEditorView: View {
    @State public var text1: String = ""
    @State public var text2: String = ""
    @State public var textField: String = ""
    @State var currentSet: UUID?
    @State var savedFlashCardNames = LocalStorage.allFlashcardSets
    @State var selection = FlashcardSet(flashcardSetName: "")
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                TextField("Add New Set", text: $textField)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
//                    .overlay
                        Picker("", selection: $selection) {
                        ForEach(savedFlashCardNames) { set in
                            Text(set.flashcardSetName).tag(set)
                        }
                    }
                    .padding(.trailing, 8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .onChange(of: selection) { newValue in
                        currentSet = newValue.id
                    }
                Button {
                    // MARK: Need to save only the name of the card as a title
                    currentSet = LocalStorage.addSet(name: textField)
                } label: {
                    Text("Save")
                }
            }
                // First view of the TextEditor
                Text("Question")
                    .foregroundColor(.gray);
                TextEditor(text: $text1)
                    .frame(height: 250)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.2), lineWidth: 2)
                    )
                // Second view of the TextEditor
                Text("Answer")
                    .foregroundColor(.gray);
                TextEditor(text: $text2)
                    .frame(height: 250)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.2), lineWidth: 2)
                    )
            
                VStack {
                    Button {
                        // MARK: Need to add the card to the saved title name
                        LocalStorage.add(card: Card(question: text1, answer: text2), to: currentSet)
                        text1 = ""
                        text2 = ""
                    } label: {
                        Text("Add Card")
                    }
                }
            }
            .padding()
            // MARK: ????
            .onAppear {
                print(LocalStorage.allFlashcardSets)
            }
        }
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}

