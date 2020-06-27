//
//  AddBookView.swift
//  Bookworm
//
//  Created by Vegesna, Vijay V EX1 on 6/25/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentation

    @State var title = ""
    @State var author = ""
    @State var rating = 3
    @State var review = ""
    @State var genre = ""
    
    let genres = ["Horror", "Comedy", "Action", "Thriller", "Fantasy", "Kids", "Mystery", "Poetry", "Romance"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("title", text: $title)
                    TextField("author", text: $author)
                    Picker("Enter genre", selection: $genre) {
                        ForEach(genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    RatingsView(rating: $rating)
                    TextField("Review", text: $review)
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.review = self.review
                        newBook.genre = self.genre
                        try? self.moc.save()
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book", displayMode: .automatic)
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        AddBookView()
        }
    }
}
