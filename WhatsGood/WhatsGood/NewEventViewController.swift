//
//  ViewController.swift
//  WhatsGood
//
//  Created by Ayush Mehra on 1/17/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import MapKit
import CoreLocation
import UIKit
import Parse


class NewEventViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var startTimePicker: UIDatePicker!
    
    @IBOutlet var timeSwitch: UISegmentedControl!
    
    @IBOutlet var endTimePicker: UIDatePicker!
    
    @IBOutlet var addressTextField: UITextField!

    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var eventLat = 0.0
    var eventLong = 0.0
    var addressError = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        endTimePicker.hidden = true;
        
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        titleTextField.delegate = self;
        descriptionTextField.delegate = self;
        addressTextField.delegate = self;
        
        startTimePicker.minimumDate = NSDate()
        endTimePicker.minimumDate = NSDate()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func timeSwitchedAction(sender: AnyObject) {
        if(endTimePicker.hidden) {
            endTimePicker.hidden = false;
            startTimePicker.hidden = true;
        } else {
            endTimePicker.hidden = true;
            startTimePicker.hidden = false;
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        if(textField == titleTextField) {
            titleTextField.resignFirstResponder()
            descriptionTextField.becomeFirstResponder()
        }
        else if(textField == descriptionTextField) {
            descriptionTextField.resignFirstResponder()
        }
        else if(textField == addressTextField) {
            addressTextField.resignFirstResponder()
        }
        
        return true
    }
    
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        NSLog("h3llo");
        let location = locations.last as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        NSLog("fuck this shit");
        titleTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
    }
    
    @IBAction func addressEntered(sender: AnyObject) {
        NSLog("reached")
        
        addressError = false
        
        
        var query = addressTextField.text
        
        query = query.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        var url = "https://maps.googleapis.com/maps/api/geocode/json?address="+query+"&key=AIzaSyBhCmc7MBpFaPe4WZvIRSHysplrv4Aw1V4"
        
        let data: NSData? = NSData(contentsOfURL: NSURL(string: url)!)
        
        
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let dict = jsonObject as? NSDictionary
        
        let status = dict?.valueForKey("status") as String
        
        NSLog(status)
        
        if(status=="OK") { //search query had results
            
            
            var json = dict?.valueForKey("results") as NSArray
            
            var results = json[0] as NSDictionary
            
            var geometry = results.valueForKey("geometry") as NSDictionary
            
            var location = geometry.valueForKey("location") as NSDictionary
            
            var latitude = location.valueForKey("lat") as Double
            var longitude = location.valueForKey("lng") as Double
            
            
            
            
            NSLog("latitude: "+String(format: "%f", latitude))
            NSLog("long: "+String(format: "%f", longitude))
            
            eventLat = latitude
            eventLong = longitude
            
            
            
            
            addressTextField.resignFirstResponder()
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            //MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            var annotation = MKPointAnnotation()
            annotation.setCoordinate(center)
            self.mapView.addAnnotation(annotation)
            
            
            self.mapView.setRegion(region, animated: true)
            
            UIView.animateWithDuration(0.25, animations: {
                self.view.frame.origin.y += 175
                
                }, completion: {
                    (value: Bool) in
            })
            
            
        }
        else { //search query had no results
            addressError = true
            var alert = UIAlertController(title: "Hmmmm", message: "Could not find that place on the map. Try something else?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK, thanks", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            addressTextField.becomeFirstResponder()
            
            
        }
        
        
        
        
        
        /*
        var error: NSError?
        var locationDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
*/
        
        //var latitude: AnyObject? = locationDictionary.valueForKey("results")
        
        //var results: AnyObject? = locationDictionary["status"]
        
        
        //NSLog(locationDictionary.description)
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @IBAction func addressGainedFocus(sender: AnyObject) {
        UIView.animateWithDuration(0.25, animations: {
            
            if(!self.addressError) {
                self.view.frame.origin.y -= 175
            }
            
            
            }, completion: {
                (value: Bool) in
        })
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    
    @IBAction func saveNewEvent(sender: AnyObject) {
        
        
        if(empty(titleTextField.text) || empty(descriptionTextField.text) || eventLat==0.0 || eventLong==0.0) { //a field is empty
            var alert = UIAlertController(title: "Hmmmm", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok, thanks", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else { //everything
            
            let eventPoint = PFGeoPoint(latitude:eventLat, longitude:eventLong)
            
            var post = PFObject(className:"Post")
            post["Title"] = titleTextField.text
            post["Description"] = descriptionTextField.text
            post["Downvotes"] = 0
            post["Location"] = eventPoint
            post["Upvotes"] = 0
            post["startTime"] = startTimePicker.date
            post["endTime"] = endTimePicker.date
            post.saveInBackgroundWithTarget(nil, selector: nil)
/*

            
            var startDate: NSDate = startTimePicker.date
            NSLog(String(format: "%@", startDate))
            
            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            var strDate = dateFormatter.stringFromDate(startTimePicker.date)
            NSLog(strDate)

*/
        }
        
    }
    
    
    func empty(input: NSString) -> Bool {
        var set: NSCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        if (input.stringByTrimmingCharactersInSet(set) == "")
        {
            return true
        }
        return false
    }
    
    @IBAction func startTimeChanged(sender: AnyObject) {
        endTimePicker.minimumDate = startTimePicker.date
    }
    
    @IBAction func endTimeChanged(sender: AnyObject) {
        startTimePicker.maximumDate = endTimePicker.date
    }
    
}

