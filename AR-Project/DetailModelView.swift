//
//  DetailModelView.swift
//  AR-Project
//
//  Created by Yegor on 18.02.2022.
//

import SwiftUI
import SceneKit

struct DetailModelView: View {
    
    @Binding var isDirection: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                SceneView(
                    scene: SCNScene(named: "toy_biplane.usdz"),
                    options: [.autoenablesDefaultLighting, .allowsCameraControl]
                ).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                Text("Some title")
                    .font(.title)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.5))
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    isDirection = true
                } label: {
                    HStack {
                        Text("Direct")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }.frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(16)
                }
            }.padding(10)
        }.padding(.horizontal, 16)
    }
    
}

struct DetailModelView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailModelView(isDirection: .constant(false))
    }
    
}
