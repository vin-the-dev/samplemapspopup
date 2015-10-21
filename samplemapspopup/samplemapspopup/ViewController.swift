//
//  ViewController.swift
//  samplemapspopup
//
//  Created by Vineeth Vijayan on 21/10/15.
//  Copyright © 2015 Vineeth Vijayan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mapView.delegate = self
        
        let newYorkLocation = CLLocationCoordinate2DMake(28.6100, 77.2300)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = newYorkLocation
        dropPin.title = "New Delhi"
        mapView.addAnnotation(dropPin)
        
        let span = MKCoordinateSpan(latitudeDelta: newYorkLocation.latitude + 10, longitudeDelta: newYorkLocation.longitude + 10)
        let region = MKCoordinateRegion(center: newYorkLocation, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation") as MKAnnotationView!
        
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
            annotationView.image = UIImage(named: "ship_icon")
        } else {
            annotationView.annotation = annotation;
        }
        
        
        let button : UIButton = UIButton(type: UIButtonType.InfoDark)
        
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        annotationView.rightCalloutAccessoryView = button
        annotationView.canShowCallout = true
        
        
        return annotationView
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        self.mapView.deselectAnnotation(view.annotation, animated: true)
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let popover = nav.popoverPresentationController
        vc.preferredContentSize = CGSizeMake(300,50)
        
        popover!.sourceView = view
        
        let orgin = view.bounds.origin
        popover!.sourceRect = CGRect(origin: orgin, size: view.bounds.size)
        
        self.presentViewController(nav, animated: true, completion: nil)
        
    }
}

