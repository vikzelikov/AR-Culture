//
//  Model.swift
//  AR-Project
//
//  Created by Yegor on 06.02.2022.
//

import UIKit
import RealityKit
import Combine

class Model {
    
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        self.image = UIImage(named: modelName) ?? UIImage()
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { completion in
                // handle our error
                print("ERROR: unable to load model entity with name: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // get our model
                self.modelEntity = modelEntity
            })
    }
    
}
