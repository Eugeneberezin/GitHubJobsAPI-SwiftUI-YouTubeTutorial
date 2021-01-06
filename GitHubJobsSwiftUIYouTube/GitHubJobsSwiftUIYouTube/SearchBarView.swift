//
//  SearchBarView.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/1/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @State private var isEditing = false
    var placeHolder: String
    
    var body: some View {
        
        HStack {
            TextField(placeHolder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onTapGesture {
                    isEditing = true
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,  maxWidth: .infinity,   alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                text = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                            .padding(.horizontal, 10)

                            if isEditing {
                                Button(action: {
                                    isEditing = false
                                    text = ""
                                    // Dismiss the keyboard
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    
                                }, label: {
                                    
                                    Image(systemName: "arrow.uturn.left.square")
                                        .font(.title)
                                    
                                })
                                .padding(.trailing, 10)
                                .transition(.move(edge: .trailing))
                                .animation(.default)
                                
                            }
                            
                            
                        }
                        
                    }
                
                
                )
            
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), placeHolder: "Preview")
            .previewLayout(.sizeThatFits)
    }
}
