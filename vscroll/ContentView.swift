//
//  ContentView.swift
//  vscroll
//
//  Created by Russell Harrower on 17/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//
import SwiftUI
import AVKit
import KingfisherSwiftUI
import CoreLocation

struct ContentView: View {
    @State var isNavigationBarHidden: Bool = true
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
    
    
    
    @State var showingDetail = false
    @State var stations: [Station] = []
    @State var posts: [Program] = []
    @State var lifeshows: [Program] = []

   var body: some View {
        NavigationView {
        GeometryReader { geo in
            Group {
                if self.posts.isEmpty {
                Text("Loading")
                //this must be empty
                //.navigationBarHidden(true)
                      
            } else {
            ScrollView {
                VStack(alignment: .leading){
                    MediaPlayerView()
                    .frame(width:geo.size.width, height:270)
                    
               // }.frame(width:geo.size.width, height:250)
                    .onTapGesture {
                     self.showingDetail.toggle()
                    }
                        .sheet(isPresented: self.$showingDetail) {
                            MediaPlayerView()
                                
                        }
               // Divider()
              //  VStack(alignment: .trailing){
                Spacer(minLength: 2)
                    //STATIONS
                    Text("Our Stations")
                    .lineSpacing(30)
                    .padding(5)
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            ForEach(self.stations) { station in
                                                //return
                                               Button(action: {
                                                AdStichrApi.station = station.name
                                                MusicPlayer.shared.startBackgroundMusic(url:station.listenlive, type: "radio")
                                                self.showingDetail.toggle()
                                               }) {
                                                
                                                KFImage(URL(string: station.imageurl)!)
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .frame(width:geo.size.width / 2.5, height:geo.size.width / 2.5)
                                              
                                                .sheet(isPresented: self.$showingDetail) {
                                                    MediaPlayerView()
                                                        
                                                }
                                            }
                                        }
                                            
                                        }.frame(height: geo.size.width / 2.5)
                    }.frame(height: geo.size.width / 2.5)
                    
                    Divider()
                    //PODCAST
                    Text("DRN1 Shows")
                    .lineSpacing(20)
                    .padding(5)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 10) {
                            ForEach(self.posts) { post in
                                //return
                                NavigationLink(destination: Podcasts(post: post)){
                                    KFImage(URL(string: post.icon))
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width:geo.size.width / 3, height:geo.size.width / 3)
                                    
                                }
                            }
                            
                            

                        }.frame(height: geo.size.width / 3)
                    }.frame(height: geo.size.width / 3)
                    
                    
                    
                    //1LIFE SHOWS
                    Divider()
                                    //PODCAST
                                    Text("1Life Shows")
                                    .lineSpacing(20)
                                    .padding(5)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            ForEach(self.lifeshows) { post in
                                                //return
                                                NavigationLink(destination: Podcasts(post: post)){
                                               
                                                 KFImage(URL(string: post.icon)!)
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .frame(width:geo.size.width / 4, height:geo.size.width / 4)
                                                }
                                            }
                                            
                                            

                                        }.frame(height: geo.size.width / 4)
                                    }.frame(height: geo.size.width / 4)
                    
                }
           
            //   CityListScene()
                
            }
            }
            }
                           .navigationBarTitle("")
                           //.navigationBarBackButtonHidden(true)
                           .navigationBarHidden(true)
            }
        }
         .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
         //   self.navigationViewStyle(StackNavigationViewStyle())
            
          
            Api().getShows(station:"1Life"){ (posts) in
                self.lifeshows = posts
            }
            
              Api().getShows(station:"DRN1"){ (posts) in
                self.posts = posts
            }
            Api().getStations { (stations) in
                           self.stations = stations
            }
            
    
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
