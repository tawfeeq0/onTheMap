//
//  MapVC.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    

    @IBOutlet weak var mapView: MKMapView!
    let studentLocParams = StudentLocParams(limit:100,skip:0,order:"-updatedAt",search:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        getLocationList()
        
    }
    
    func getLocationList(){
        StudentLoc.getLocationList(params: studentLocParams) { (message,response) in
            guard let response = response else{
                self.showAlert(HttpLoginStatus.RESPONSE_ERROR.rawValue)
                return
            }
            if let results = response.results {
                for student in results {
                    let annotation = MKPointAnnotation()
                    annotation.title = "\(student.firstName ?? "N/A") \(student.lastName ?? "N/A")"
                    annotation.subtitle = student.mediaURL!
                    annotation.coordinate = CLLocationCoordinate2D(latitude: student.latitude!, longitude: student.longitude!)
                    self.mapView.addAnnotation(annotation)
                }
            }
            else {
                self.showAlert(message)
                return
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        self.logout()
    }
    
    @IBAction func reloadLocations(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        getLocationList()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "addLocation", sender: nil)
    }
}

extension MapVC :MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "studentLoc") as? MKPinAnnotationView
        if let annotationView = annotationView {
            annotationView.annotation = annotation
        }
        else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "studentLoc")
            annotationView!.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView!.rightCalloutAccessoryView = btn
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let url = view.annotation?.subtitle{
                openURL(url: url!)
            }
        }
    }
    
}
