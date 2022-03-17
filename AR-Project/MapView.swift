//
//  InitialView.swift
//  AR-Project
//
//  Created by Yegor on 06.02.2022.
//

import SwiftUI
import MapKit
import UIKit

struct MapView : View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @State private var isDetailModal = false
    @State private var isShowDirection = false

    var annotationItems: [MyAnnotationItem] = [
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 59.906759, longitude: 30.478430)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 59.909708, longitude: 30.491354)),
    ]
    
    var body: some View {
        ZStack {
            LazyView {
                MapDirectionsView(from: viewModel.region.center, to: annotationItems.first!.coordinate)
            }.hiddenNavigationBarStyle()
                .navigatePush(when: $isShowDirection)
            
            Map(
                coordinateRegion: self.$viewModel.region,
                showsUserLocation: true,
                annotationItems: annotationItems
            ) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    Button {
                        self.isShowDirection.toggle()
                    } label: {
                        VStack{

                        }.frame(width: 25, height: 25)
                            .background(Color.green)
                            .cornerRadius(25)
                            .padding(2)
                            .background(Color.black)
                            .cornerRadius(26)
                    }
                }
            }.ignoresSafeArea()
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                .sheet(isPresented: $isDetailModal) {
                    DetailModelView()
                }
        }
    }
    
}

struct MyAnnotationItem: Identifiable {
    
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
    
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.903389, longitude: 30.487659),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("ERROR map")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(
                center: locationManager.location!.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
