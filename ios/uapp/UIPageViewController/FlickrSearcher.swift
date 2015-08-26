//
//  FlickrSearcher.swift
//  flickrSearch
//
//  Created by Richard Turton on 31/07/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

let apiKey = "32036da6f917a5a5bf879ce5ba1b6863"

struct FlickrSearchResults {
  let searchTerm : String
  let searchResults : [FlickrPhoto]
}

class FlickrPhoto : Equatable {
  var thumbnail : UIImage?
  var largeImage : UIImage?
  let photoID : String
  let farm : Int
  let server : String
  let secret : String
  
  init (photoID:String,farm:Int, server:String, secret:String) {
    self.photoID = photoID
    self.farm = farm
    self.server = server
    self.secret = secret
  }
  
  func flickrImageURL(size:String = "m") -> NSURL {
    return NSURL(string: "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!
  }
  
  func loadLargeImage(completion: (flickrPhoto:FlickrPhoto, error: NSError?) -> Void) {
    let loadURL = flickrImageURL("b")
    let loadRequest = NSURLRequest(URL:loadURL)
    NSURLConnection.sendAsynchronousRequest(loadRequest,
      queue: NSOperationQueue.mainQueue()) {
        response, data, error in
        
        if error != nil {
          completion(flickrPhoto: self, error: error)
          return
        }
        
        if data != nil {
          let returnedImage = UIImage(data: data!)
          self.largeImage = returnedImage
          completion(flickrPhoto: self, error: nil)
          return
        }
        
        completion(flickrPhoto: self, error: nil)
    }
  }
  
  func sizeToFillWidthOfSize(size:CGSize) -> CGSize {
    if thumbnail == nil {
      return size
    }
    
    let imageSize = thumbnail!.size
    var returnSize = size
    
    let aspectRatio = imageSize.width / imageSize.height
    
    returnSize.height = returnSize.width / aspectRatio
    
    if returnSize.height > size.height {
      returnSize.height = size.height
      returnSize.width = size.height * aspectRatio
    }
    
    return returnSize
  }
  
}

func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
  return lhs.photoID == rhs.photoID
}

class Flickr {
  
  let processingQueue = NSOperationQueue()
  
        
  private func flickrSearchURLForSearchTerm(searchTerm:String) -> NSURL {
    
    let escapedTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
    return NSURL(string: URLString)!
  }
  
  
}
