//
//  ViewController.swift
//  Exercise-2
//
//  Created by MacStudent on 2020-01-16.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    var locArray2D : [CLLocationCoordinate2D] = []
    var locArray : [CLLocation] = []

    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // define lat and long
       
                let latitude: CLLocationDegrees = 43.64
                let longitude: CLLocationDegrees = -79.38
                
                // define delta lat and long
                
                let latDelta : CLLocationDegrees = 0.05
                let longDelta : CLLocationDegrees = 0.05
                
                //defione span
                let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                
                // define location
                
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                // define the region
                
                let region = MKCoordinateRegion(center: location, span: span)
                
                // set the region on the map
                mapView.setRegion(region, animated: true)
                
                let uitpgr = UITapGestureRecognizer(target: self, action: #selector(tapPress))
                
                mapView.addGestureRecognizer(uitpgr)

                
                
            }
            
           
            
            @objc func tapPress(gestureRecogniser: UIGestureRecognizer)
            {
              
                let touchPoint = gestureRecogniser.location(in: mapView)
                          let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                          
                          let annotation = MKPointAnnotation()
                          annotation.coordinate = coordinate
                mapView.removeAnnotation(annotation)

                if mapView.annotations.count < 3
                {
                let touchPoint = gestureRecogniser.location(in: mapView)
                    let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    
                    
                    
                    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locArray.append(location)
                let location2D = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                locArray2D.append(location2D)
                  
                mapView.addAnnotation(annotation)

                }
                if mapView.annotations.count == 3
                {
                    addPolygon()
                    
                }

        }
            
            
            public func addPolygon()
               {
                mapView.delegate=self
                    let polygon = MKPolygon(coordinates: &locArray2D, count: locArray2D.count)
                    mapView.addOverlay(polygon)
                }

        }

extension ViewController: MKMapViewDelegate
        {

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
             if overlay is MKPolygon{
                let renderer = MKPolygonRenderer(overlay: overlay)
                renderer.fillColor = UIColor.orange.withAlphaComponent(0.5)
                renderer.strokeColor = UIColor.green
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer()
        }
            
            func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
                
                mapView.removeAnnotation(view.annotation!)
            }
            
            
            
            
            func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                
                let overlays = mapView.overlays
                mapView.removeOverlays(overlays)
                locArray2D.removeAll()
                locArray.removeAll()
                mapView.removeAnnotation(view.annotation!)
               
                addLocation2d()
                addToLocationArray()
                
            }
            
            
            
            
            func addLocation2d()
            {
                let temp = mapView.annotations
                
                for i in temp{
                    locArray2D.append(i.coordinate)
                }
                //location2d.append(contentsOf: temp)
            }
            
            func addToLocationArray()
            {
                let temp = mapView.annotations
                
                for i in temp{
                    var location = CLLocation()
                    location = CLLocation(latitude: i.coordinate.latitude, longitude: i.coordinate.longitude)
                    locArray.append(location)
                    
                }
                
                
            }
    
    
    }
            
            
            

        

