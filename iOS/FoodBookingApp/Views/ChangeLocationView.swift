//
//  ChangeLocationVIew.swift
//  TicketBookingApp
//
//  Created by HUY TON on 19/8/24.
//

import SwiftUI
import MapKit



struct DraggablePin: View {
    
    @Binding var coordinate: CLLocationCoordinate2D
    var proxy: MapProxy
    @State private var isActive = false
    @State private var translation: CGSize = .zero
    
    // MARK: Move into new location
    var onCoordinateChange: (CLLocationCoordinate2D) -> ()
    
    var body: some View {
        GeometryReader { geo in
            
            let frame = geo.frame(in: .global)
            
            Image(systemName: "mappin")
                .foregroundStyle(Color.red.gradient)
                .font(.title)
                .symbolEffect(.pulse)
                .onChange(of: isActive, initial: false) { oldValue, newValue in
                    
                    let position = CGPoint(x: frame.midX, y: frame.midY)
                    if let newCoordinate = proxy.convert(position, from: .global) {
                        
                            self.coordinate = newCoordinate
                            translation = .zero
                            onCoordinateChange(newCoordinate)
                    }
                }
        }
        .contentShape(.rect)
        .frame(width: 30, height: 40)
        .animation(.snappy, body: {
            content in
            content
                .scaleEffect(isActive ? 1.3 : 1, anchor: .bottom)
        })
        .offset(translation)
        .gesture(
            LongPressGesture(minimumDuration: 0.1)
                .onEnded {
                    isActive = $0
                }
                .simultaneously(with:
                     DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if isActive { translation = value.translation }
                    }.onEnded { value in
                        if isActive { isActive = false }
                    }
                )
        )
        .navigationTitle("New Address")
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct ChangeLocationView: View {
    
    @EnvironmentObject var vmMap : MapViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        MapReader { proxy in
            Map(position: $vmMap.camera) {
                
                Annotation("You are here!", coordinate: vmMap.coordinate) {
                    
                    DraggablePin(coordinate: $vmMap.coordinate, proxy: proxy) { newCoordinate in
                        
                        // MARK: Update camera location
                        let newRegion = MKCoordinateRegion(
                            center: newCoordinate,
                            span: vmMap.mapSpan
                        )
                        withAnimation(.smooth) {
                            vmMap.updateCamera(region: newRegion)
                            print("Map Camera changed!")
                        }
                        
                    }
                }
            }
            .onMapCameraChange(frequency: .continuous) { ctx in
                // MARK: Update camera span of this View when user zoom
                vmMap.updateMapSpan(ctx.region.span)
            }
            
            .tint(Color.red.gradient)
            .mapControls {
                MapUserLocationButton()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    @StateObject var vmMap = MapViewModel()
    
    return ChangeLocationView()
                .environmentObject(vmMap)

}
