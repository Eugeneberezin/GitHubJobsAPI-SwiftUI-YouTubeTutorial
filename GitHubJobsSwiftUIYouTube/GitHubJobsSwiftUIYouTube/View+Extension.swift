//
//  View+Extension.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 2/11/21.
//


import Foundation
import SwiftUI

extension View {
    func listOnlyView() -> some View {
        switch UIDevice.current.userInterfaceIdiom {

        default:
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}
