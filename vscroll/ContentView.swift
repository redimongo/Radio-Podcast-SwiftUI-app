//
//  ContentView.swift
//  vscroll
//
//  Created by Russell Harrower on 17/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI
import AVKit
import RemoteImage

struct ContentView: View {
    
    @State var isNavigationBarHidden: Bool = true
    
    
    @State var showingDetail = false
    @State var stations: [Station] = []
    @State var posts: [Program] = []
    @State var lifeshows: [Program] = []

   var body: some View {
        NavigationView {
           
            Group {
            if posts.isEmpty {
                Text("Loading")
                //this must be empty
                //.navigationBarHidden(true)
                      
            } else {
            ScrollView {
                VStack(alignment: .leading){
                    MediaPlayerView()
                }.frame(height: 250)
                    .onTapGesture {
                     self.showingDetail.toggle()
                    }
                        .sheet(isPresented: self.$showingDetail) {
                            MediaPlayerView()
                                
                        }
                
                VStack(alignment: .leading){
                    
                    //STATIONS
                    Text("Our Stations")
                    .lineSpacing(30)
                    .padding(5)
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            ForEach(stations) { station in
                                                //return
                                               Button(action: {
                                                MusicPlayer.shared.startBackgroundMusic(url:station.listenlive, type: "radio")
                                                self.showingDetail.toggle()
                                               }) {
                                                RemoteImage(type: .url(URL(string:station.imageurl)!), errorView: { error in
                                                    Text(error.localizedDescription)
                                                }, imageView: { image in
                                                    image
                                                    .resizable()
                                                    .renderingMode(.original)
                    /*                                .clipShape(Circle())
                                                    .shadow(radius: 10)
                                                    .overlay(Circle().stroke(Color.red, lineWidth: 5))*/
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width:150, height:150)
                                                }, loadingView: {
                                                    Text("Loading ...")
                                                })
                                                .sheet(isPresented: self.$showingDetail) {
                                                    MediaPlayerView()
                                                        
                                                }
                                            }
                                        }
                                            
                                        }.frame(height: 150)
                                    }.frame(height: 150)
                    
                    Divider()
                    //PODCAST
                    Text("DRN1 Shows")
                    .lineSpacing(20)
                    .padding(5)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 10) {
                            ForEach(posts) { post in
                                //return
                                NavigationLink(destination: Podcasts(post: post)){
                                RemoteImage(type: .url(URL(string:post.icon)!), errorView: { error in
                                    Text(error.localizedDescription)
                                }, imageView: { image in
                                    image
                                    .resizable()
                                    .renderingMode(.original)
    /*                                .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.red, lineWidth: 5))*/
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:100, height:100)
                                }, loadingView: {
                                    Text("Loading ...")
                                })
                                }
                            }
                            
                            

                        }.frame(height: 100)
                    }.frame(height: 100)
                    
                    
                    
                    //1LIFE SHOWS
                    Divider()
                                    //PODCAST
                                    Text("1Life Shows")
                                    .lineSpacing(20)
                                    .padding(5)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            ForEach(lifeshows) { post in
                                                //return
                                                NavigationLink(destination: Podcasts(post: post)){
                                                RemoteImage(type: .url(URL(string:post.icon)!), errorView: { error in
                                                    Text(error.localizedDescription)
                                                }, imageView: { image in
                                                    image
                                                    .resizable()
                                                    .renderingMode(.original)
                    /*                                .clipShape(Circle())
                                                    .shadow(radius: 10)
                                                    .overlay(Circle().stroke(Color.red, lineWidth: 5))*/
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width:100, height:100)
                                                }, loadingView: {
                                                    Text("Loading ...")
                                                })
                                                }
                                            }
                                            
                                            

                                        }.frame(height: 100)
                                    }.frame(height: 100)
                    
                }
           
                
                
            }
            }
            }
                           .navigationBarTitle("")
                           //.navigationBarBackButtonHidden(true)
                           .navigationBarHidden(true)
                          
        }
         .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.navigationViewStyle(StackNavigationViewStyle())
            
          
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

