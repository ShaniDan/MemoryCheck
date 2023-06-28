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
    @State var savedFlashCardNames: [FlashcardSet] = []
    @StateObject var flashcardManager: FlashcardManager
    @State var selection = FlashcardSet(flashcardSetName: "")
    
    var body: some View {
            NavigationView {
                VStack {
                HStack {
                    Text("Choose a set")
                        .padding(.leading)
                        .font(.headline)
                    Spacer()
                    Picker("Choose Set", selection: $selection) {
                        ForEach(savedFlashCardNames) { set in
                            Text(set.flashcardSetName).tag(set)
                        }
                    }
                    .pickerStyle(.automatic)
                    .padding(.trailing, 8)
                    .frame(alignment: .trailing)
                    .background(Rectangle()).cornerRadius(8).foregroundColor(Color(.systemGray5))
                    .onChange(of: selection) { newValue in
                        currentSet = newValue.id
                    }
                }
                .padding(.trailing, 8)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement
                        .navigationBarTrailing) {
                            Button {
                                // MARK: Need to add the card to the saved title name
                                LocalStorage.add(card: CardModel(question: text1, answer: text2), to: currentSet)
                                text1 = ""
                                text2 = ""
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                }

                ScrollView {
                    VStack {
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
                    }
                    .padding()
                }
                // MARK: ????
                .onAppear {
                    print(LocalStorage.allFlashcardSets)
                    savedFlashCardNames = LocalStorage.allFlashcardSets
                }
            }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement
                        .navigationBarLeading) {
                            NavigationLink(destination: ListFlashcardView()) {
                                Text("Back")
                            }
                        }
                }
        }
            .navigationBarBackButtonHidden(true)
    }
}
struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(flashcardManager: FlashcardManager())
    }
}

