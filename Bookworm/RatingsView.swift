//
//  RatingsView.swift
//  Bookworm
//
//  Created by Vegesna, Vijay V EX1 on 6/26/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI

struct RatingsView: View {
    @Binding var rating: Int
    
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var onColor = Color.yellow
    var offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number < rating {
            return offImage ?? onImage
        }
        return onImage
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(rating: .constant(4))
    }
}
