//
//  DoubleSearchBarView.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/1/21.
//

import SwiftUI

struct DoubleSearchBarView: View {
    @Binding var positionSearchTerm: String
    @Binding var locationSearchTerm: String
    
    var body: some View {
        VStack {
            SearchBarView(text: $positionSearchTerm, placeHolder: "Job title")
            SearchBarView(text: $locationSearchTerm, placeHolder: "Location")
        }
    }
}

struct DoubleSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleSearchBarView(positionSearchTerm: .constant(""), locationSearchTerm: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
