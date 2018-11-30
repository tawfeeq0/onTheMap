//
//  ShowLocationVC.swift
//  onTheMap
//
//  Created by Tawfeeq on 30/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
import MapKit
class ShowLocationVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    var mark : CLPlacemark? = nil
    var mediaUrl : String? = ""
    var param : (mark:CLPlacemark?,mediaUrl:String?)? = nil
    var activityIndicator =  UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if let param = param {
            mark = param.mark
            mediaUrl = param.mediaUrl
        }
        showLocation()
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
        loadingIndicator(true)
        StudentLoc.getPublicProfile { (message, response) in
            
            guard let response = response else{
                self.loadingIndicator(false)
                return
            }
            
            if message == HttpLoginStatus.SUCCESS.rawValue {
                let info = AddLocationRequest(uniqueKey:response.user?.key,firstName:response.user?.first_name,lastName:response.user?.last_name,mapString:self.mark!.name,mediaURL:self.mediaUrl,latitude:self.mark!.location?.coordinate.latitude,longitude:self.mark!.location?.coordinate.longitude)
                
                StudentLoc.addLocation(info: info, callback: { (response) in
                    self.loadingIndicator(false)
                    guard let response = response else {
                        return
                    }
                    if response == HttpLoginStatus.SUCCESS.rawValue {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        self.showAlert(response)
                        return
                    }
                })
            }
            else {
                self.loadingIndicator(false)
                self.showAlert(message)
                return
            }
            
        }
        
    }
    
    func showLocation(){
        if let mark = mark {
            let annotation = MKPointAnnotation()
            annotation.title = mark.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: (mark.location?.coordinate.latitude)!, longitude: (mark.location?.coordinate.longitude)!)
            mapView.addAnnotation(annotation)
            mapView.region.center = (mark.location?.coordinate)!
            mapView.selectAnnotation(mapView.annotations[0], animated: true)
        }
    }
}

extension ShowLocationVC :MKMapViewDelegate{
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
    
    
    func loadingIndicator(_ show:Bool) {
        if(show){
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
            activityIndicator.center = CGPoint(x: submitButton.bounds.size.width/2, y: submitButton.bounds.size.height/2)
            submitButton.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        else{
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
