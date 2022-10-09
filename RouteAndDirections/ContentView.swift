//
//  ContentView.swift
//  RouteAndDirections
//
//  Created by Jacek Kosinski U on 09/10/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Directions!")
           
              MapView()
            
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
  
    func makeCoordinator() -> MapViewCoordinator {
      return MapViewCoordinator()
    }
    
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
      mapView.delegate = context.coordinator
      let region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 52.23185930, longitude: 21.00677160),
      span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    mapView.setRegion(region, animated: true)

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
