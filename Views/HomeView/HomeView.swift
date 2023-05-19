//
//  HomeView.swift
//  MemoryCheck
//
//  Created by Shakhnoza Mirabzalova on 4/19/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            TabView {
                FirstView()
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Home")
                            
                }
                TextEditorView()
                    .tabItem() {
                        Image(systemName: "square.and.pencil")
                        Text("Create Flashcard")
                }
                ListFlashcardView()
                    .tabItem() {
                        Image(systemName: "rectangle.and.paperclip")
                            Text("My Flashcards")
                }
            }
        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
