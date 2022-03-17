//
//  InitialView.swift
//  AR-Project
//
//  Created by Yegor on 06.02.2022.
//

import SwiftUI

struct InitialView: View {
    
    init() {
        // common view configs
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
        
        UIScrollView.appearance().keyboardDismissMode = .onDrag
        
        if #available(iOS 15.0, *) {
            let appearance: UITabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        TabBarView()
    }
    
}
