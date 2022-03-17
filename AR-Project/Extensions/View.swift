//
//  View.swift
//  AR-Project
//
//  Created by Yegor on 06.02.2022.
//

import SwiftUI

extension View {
    
    func hiddenNavigationBarStyle() -> some View {
        self
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    // MARK: - navigation
    func navigatePush(
        when toggle: Binding<Bool>
    ) -> some View {
        NavigationLink(
            destination: self.hiddenNavigationBarStyle(),
            isActive: toggle
        ) {
            EmptyView()
        }.hidden()
            .frame(width: 0, height: 0)
    }
    
}

// for prevent create view before it presented with ViewModel
struct LazyView<Content: View>: View {
    
    var content: () -> Content
    var body: some View {
       self.content()
    }
    
}
