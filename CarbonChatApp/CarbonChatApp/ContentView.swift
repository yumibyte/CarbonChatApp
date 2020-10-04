import SwiftUI
import MapKit

//let park = Park(filename: "MagicMountain")
let mapView = MKMapView(frame: UIScreen.main.bounds)

struct MapView: UIViewRepresentable {
  func makeUIView(context: Context) -> MKMapView {
//
//    // Think of a span as a tv size, measure from one corner to another
//    let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
//    let region = MKCoordinateRegion(center: park.midCoordinate, span: span)
//
//    mapView.region = region
//    mapView.delegate = context.coordinator

    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  // Acts as the MapView delegate
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
      self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MKPolygon {
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.strokeColor = .magenta
        return polygonView
      }
      return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let annotationView = CategoryAnnotationView(annotation: annotation, reuseIdentifier: "Category")
      annotationView.canShowCallout = true
      return annotationView
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}

struct ContentView: View {
  @State var mapBoundary = false
  @State var mapOverlay = false
  @State var mapPins = false
  @State var mapCharacterLocation = false
  @State var mapRoute = false

  var body: some View {
    NavigationView {
      MapView()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading:
          HStack {
            Button(":Bound:") {
              self.mapBoundary.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapBoundary ? .white : .red)
            .background(mapBoundary ? Color.green : Color.clear)

            Button(":Overlay:") {
              self.mapOverlay.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapOverlay ? .white : .red)
            .background(mapOverlay ? Color.green : Color.clear)

            Button(":Pins:") {
              self.mapPins.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapPins ? .white : .red)
            .background(mapPins ? Color.green : Color.clear)

            Button(":Characters:") {
              self.mapCharacterLocation.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapCharacterLocation ? .white : .red)
            .background(mapCharacterLocation ? Color.green : Color.clear)

            Button(":Route:") {
              self.mapRoute.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapRoute ? .white : .red)
            .background(mapRoute ? Color.green : Color.clear)
          }
        )
    }
  }

  func addOverlay() {
    // TODO: Implement
  }

  func addCateogoryPins() {
    // 1
    guard let categories = Category.plist("StateCoords") as?
            [[String: String]] else { return }

    // 2
    for category in categories {
      let coordinate = Category.parseCoord(dict: category, fieldName: "location")
      let title = category["name"] ?? ""
      let typeRawValue = Int(category["type"] ?? "0") ?? 0
      let type = CategoryType(rawValue: typeRawValue) ?? .misc
      let subtitle = category["subtitle"] ?? ""
      // 3
      let annotation = CategoryAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
      mapView.addAnnotation(annotation)
    }
  }

  func addRoute() {
    // TODO: Implement
  }

  func addBoundary() {
    // TODO: Implement
  }

  func addCharacterLocation() {
    // TODO: Implement
  }

  func updateMapOverlayViews() {
    mapView.removeAnnotations(mapView.annotations)
    mapView.removeOverlays(mapView.overlays)

    if mapBoundary { addBoundary() }
    if mapOverlay { addOverlay() }
    if mapPins { addCateogoryPins() }
    if mapCharacterLocation { addCharacterLocation() }
    if mapRoute { addRoute() }
  }
}

