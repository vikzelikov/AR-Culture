//
//  TabBarView.swift
//  AR-Project
//
//  Created by Yegor on 06.02.2022.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        NavigationView {
            TabView {
                ContentView()
                    .hiddenNavigationBarStyle()
                    .tabItem {
                        Image(systemName: "xmark").renderingMode(.template)

                        Text("AR")
                    }


                MapView()
                    .hiddenNavigationBarStyle()
                    .tabItem {
                        Image(systemName: "xmark").renderingMode(.template)

                        Text("Map")
                    }
            }.accentColor(.white)
                .hiddenNavigationBarStyle()
                .edgesIgnoringSafeArea(.top)
        }.navigationViewStyle(.stack)
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarView()
    }
    
}
