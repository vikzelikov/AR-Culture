//
//  MapDirectionsView.swift
//  AR-Project
//
//  Created by Yegor on 17.03.2022.
//

import SwiftUI
import MapKit

struct MapDirectionsView: View {
    
    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D
    
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack(alignment: .topLeading) {
            MapViewRepresentable(from: from, to: to)

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .frame(width: 50, height: 50)
                    .background(Color.white)
                    .cornerRadius(100)
                    .shadow(radius: 5)
                    .padding(15)
            }
        }
    }
    
}

struct MapViewRepresentable: UIViewRepresentable {

    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: from.latitude, longitude: from.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: from)
        let p2 = MKPlacemark(coordinate: to)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .walking

        let directions = MKDirections(request: request)
           
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true
            )
        }
            
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }

    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(
            _ mapView: MKMapView,
            rendererFor overlay: MKOverlay
        ) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
    
}
