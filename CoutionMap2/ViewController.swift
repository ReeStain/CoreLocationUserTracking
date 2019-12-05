//
//  ViewController.swift
//  CoutionMap2
//
//  Created by om on 2019/10/16.
//  Copyright © 2019 t417046. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import UserNotifications

class ViewController: UIViewController,CLLocationManagerDelegate,UNUserNotificationCenterDelegate {
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        initMap()
   
    }
    
    func setupLocationManager(){
        //CLLocationMangerをインスタンス化
        locationManager = CLLocationManager()
       
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        locationManager.requestWhenInUseAuthorization()
        
        
        //Switchで端末の位置情報使用許可ステータス
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locationManager.delegate = self
                locationManager.startUpdatingLocation()
                
                break
            
            default:
                break
            }
        }
        //if形式で位置情報の使用許可ステータス取得
//        let status = CLLocationManager.authorizationStatus()
//        if status == .authorizedWhenInUse {
//            locationManager.delegate = self
//            locationManager.startUpdatingLocation()
//            mapView.showsUserLocation = true
//        }
        
    
    }
    
    //位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("error")
       }
    
    //位置情報を取得してコンソールに表示するメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        //let latitude = location?.coordinate.latitude
        //let longitude = location?.coordinate.longitude
        
        
        //UnWrap
        if let latitude = location?.coordinate.latitude {
            if let longitude = location?.coordinate.longitude{
        //緯度と経度の表示
        print("緯度：\(latitude)\n軽度：\(longitude)")
            }
        }

//        if let coordinate = locations.last?.coordinate {
//               // 現在地を拡大して表示する
//               let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//               mapView.region = region
//               }
 }
     
    func initMap() {
            //縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02

        //現在位置表示の有効化
        mapView.showsUserLocation = true
        //現在位置設定
        mapView.userTrackingMode = .follow
    }
    
    /*func notification() {
        //領域通知を通知するregion
        let triggerCoordinate = CLLocationCoordinate2DMake(35.1331128, 137.1482507)
        let radius = 100.0
        let identifier = "Sample"
        
        let notification = UILocalNotification()
        notification.alertBody = "到着しました"
        notification.regionTriggersOnce = false
        
        notification.region = CLCircularRegion(circularRegionWithCenter: triggerCoordinate, radius: radius, identifier: identifier)
            
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
    }*/
    
    func notification(){
        
        let content = UNMutableNotificationContent()
        content.title = "到着しました"
        content.title = "大学です"
        content.body = ""
        content.sound = UNNotificationSound.default
        
        let coordinate = CLLocationCoordinate2DMake(35.1389819, 137.1492194)
        let region = CLCircularRegion.init(center: coordinate, radius: 50, identifier: "Universty")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger.init(region: region, repeats: true)
        
        let request = UNNotificationRequest.init(identifier: "LocationNotification", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    
            
    }




