//
//  ContentView.swift
//  RouteAndDirections
//
//  Created by Jacek Kosinski U on 09/10/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Directions!")
           
              MapView(directions: $directions)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct MapView: UIViewRepresentable {
  typealias UIViewType = MKMapView
  
    @Binding var directions: [String]
    
    func makeCoordinator() -> MapViewCoordinator {
      return MapViewCoordinator()
    }
    
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
      mapView.delegate = context.coordinator
      
      
//      let region = MKCoordinateRegion(
//      center: CLLocationCoordinate2D(latitude: 52.23185930, longitude: 21.00677160),
//      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    mapView.setRegion(region, animated: true)
      let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.71, longitude: -74),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
      mapView.setRegion(region, animated: true)
      
      
//      // NYC
//      let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 20))
//
//      // Boston
//      let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 21.00677160, longitude: 52.23185930))
      
      // NYC
      let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))

      // Boston
      let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))


      let request = MKDirections.Request()
      request.source = MKMapItem(placemark: p1)
      request.destination = MKMapItem(placemark: p2)
      request.transportType = .automobile

      directions.calculate { response, error in
        guard let route = response?.routes.first else { return }
        mapView.addAnnotations([p1, p2])
        mapView.addOverlay(route.polyline)
        mapView.setVisibleMapRect(
          route.polyline.boundingMapRect,
          edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
          animated: true)
        self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
      }
      
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5
        return renderer
      }
    }
    
}
