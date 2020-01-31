//
//  LocationManager.swift
//  CoutionMap2
//
//  Created by Furuya Rei on 2020/01/31.
//  Copyright © 2020 t417046. All rights reserved.
//
import CoreLocation
import Foundation

class LocationManager:NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
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
}
