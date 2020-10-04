//
//  CategoryAnnotationView.swift
//  CarbonChatApp
//
//  Created by Ashley Raigosa on 10/4/20.
//

import MapKit

class CategoryAnnotationView: MKAnnotationView {
  // 1
  // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
  // 2
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard
            let categoryAnnotation = self.annotation as? CategoryAnnotation else {
            return
        }
    
        image = categoryAnnotation.type.image()
    }
}
