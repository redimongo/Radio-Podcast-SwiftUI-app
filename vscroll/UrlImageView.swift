//
//  UrlImageView.swift
//  vscroll
//
//  Created by Russell Harrower on 18/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI

struct UrlImageView: View {
    @State var posts: [Program] = []

      var body: some View {
      /*
              ForEach(posts){ post in
          
              Text(post.title)
          .frame(width: 200, height: 200)
                      /*RemoteImage(type: .url(URL(string:post.icon)!), errorView: { error in
                              Text(error.localizedDescription)
                          }, imageView: { image in
                              image
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                          }, loadingView: {
                              Text("Loading ...")
                          })*/
                  
                  
          
          }.onAppear{
              Api().getPosts { (posts) in
                  self.posts = posts
              }
          }*/
          
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView()
    }
}
