//
//  ShowsView.swift
//  DRN1
//
//  Created by Russell Harrower on 27/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ShowsView: View {
    @State var posts: [Program] = []
    @State var lifeshows: [Program] = []
     var body: some View {
          ScrollView {
           GeometryReader { geo in
             
               VStack {
                 
                       
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
                }
              
               //   CityListScene()
                   
               }
               
           
            .onAppear {
            //   self.navigationViewStyle(StackNavigationViewStyle())
               
             
               Api().getShows(station:"1Life"){ (posts) in
                   self.lifeshows = posts
               }
               
                 Api().getShows(station:"DRN1"){ (posts) in
                   self.posts = posts
               }
            }
              
            }
       
           
           
       }


struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView()
    }
}
