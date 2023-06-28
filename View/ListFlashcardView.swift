//
//  ListFlashcardView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/29/23.

//  MARK: List of user question and answer flashcards
//  

import SwiftUI

struct ListFlashcardView: View {
    @State var savedFlashCards: [FlashcardSet] = []
    @State public var textField: String = ""
    @State var currentSet: UUID?
    @State var show = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(savedFlashCards, id: \.flashcardSetName) { cardSet in
                        NavigationLink(destination: FlashcardView(set: cardSet)) {
                            Text(cardSet.flashcardSetName)
                                .font(.headline)
                            }
                        }
                    .onDelete(perform: LocalStorage.deleteCardSet)
                    
                }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("My Flashcards")
            // FloatingButton
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButton(show: $show)
                    }
                } .padding()
               }
            }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            savedFlashCards = LocalStorage.allFlashcardSets
        }
        }
    }

struct ListFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        ListFlashcardView()
    }
}

struct FloatingButton: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            if self.show {
                NavigationLink (destination: TextEditorView(flashcardManager: FlashcardManager()), label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 40, height: 30, alignment: .trailing)
                        .padding(22)
                } )
                NavigationLink (destination: FirstView(), label: {
                    Image(systemName: "folder.badge.plus")
                        .resizable()
                        .frame(width: 40, height: 30, alignment: .trailing)
                        .padding(22)
                } )
            }
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "plus").resizable().frame(width: 30, height: 30).padding(15)
            }
            .background(Color.white)
            .foregroundColor(Color.blue)
            .clipShape(Circle())
            .rotationEffect(.init(degrees: self.show ? 180 : 0))
        }.animation(.spring())
    }
}

