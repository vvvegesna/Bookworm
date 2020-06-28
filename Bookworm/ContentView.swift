//
//  ContentView.swift
//  Bookworm
//
//  Created by Vegesna, Vijay V EX1 on 6/25/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true)]) var books: FetchedResults<Book>
    
    @State var shouldShowBookView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id:\.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack {
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                                .foregroundColor(Int(book.rating) == 1 ? Color.red : Color.black)
                            Text(book.author ?? "Unknown")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: { self.shouldShowBookView.toggle() }) { Image(systemName: "plus")})
            .sheet(isPresented: $shouldShowBookView) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static let books = [Book(context:moc)]
    static var previews: some View {
        return NavigationView {
            ContentView()
        }
    }
}
