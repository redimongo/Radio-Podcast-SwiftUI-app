//
//  CityListScene.swift
//  vscroll
//
//  Created by Russell Harrower on 26/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CityListScene: View {
       @ObservedObject var location = LocationManager()

           
           var lat: String{
               return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
           }
           
           var lon: String{
               return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
           }
           
           init() {
               self.location.startUpdating()
           }
           
           
           
           
           
           var body: some View {
                //Divider()
           
                Text("A Radio Media PTY LTD App")
                    .foregroundColor(Color.gray)
           
            }
}

struct CityListScene_Previews: PreviewProvider {
    static var previews: some View {
        CityListScene()
    }
}


