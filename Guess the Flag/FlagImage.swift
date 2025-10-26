//
//  FlagImage.swift
//  Guess the Flag
//
//  Created by Rob Downing on 10/26/25.
//
import SwiftUI

/// A reusable flag view that applies consistent styling to flag images.
struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
            .accessibilityLabel(country)
    }
}

#Preview {
    FlagImage(country: "Estonia")
}

