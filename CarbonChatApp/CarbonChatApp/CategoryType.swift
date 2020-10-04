//
//  CategoryType.swift
//  CarbonChatApp
//
//  Created by Ashley Raigosa on 10/4/20.
//

import MapKit

// 1
enum CategoryType: Int {
  case commercial = 0
  case industrial
  case residential
  case electricPower
  case transportation
  
  func image() -> UIImage {
    switch self {
    case .commercial:
      return UIImage(imageLiteralResourceName: "commercial")
    case .industrial:
      return UIImage(imageLiteralResourceName: "industrial")
    case .residential:
      return UIImage(imageLiteralResourceName: "residential")
    case .transportation:
      return UIImage(imageLiteralResourceName: "electricPower")
    case .electricPower:
      return UIImage(imageLiteralResourceName: "electricPower")
    }
  }
}

// 2
class AttractionAnnotation: NSObject, MKAnnotation {
  // 3
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let subtitle: String?
  let type: CategoryType
  
  // 4
  init(
    coordinate: CLLocationCoordinate2D,
    title: String,
    subtitle: String,
    type: CategoryType
  ) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    self.type = type
  }
}