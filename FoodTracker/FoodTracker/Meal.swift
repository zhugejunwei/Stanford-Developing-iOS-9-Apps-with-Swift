//
//  Meal.swift
//  FoodTracker
//
//  Created by 诸葛俊伟 on 5/12/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class Meal {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // Initialization should fail if there is no name or if the rating is negative.
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}