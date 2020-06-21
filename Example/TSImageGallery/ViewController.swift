//
//  ViewController.swift
//  TSImageGallery
//
//  Created by Talib Shabbir Hussain on 06/21/2020.
//  Copyright (c) 2020 Talib Shabbir Hussain. All rights reserved.
//

import TSImageGallery
import Photos
import UIKit

class ViewController: UIViewController {
    var librayImg: [ImageItem]?
    var urlImg: [ImageItem]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickFromURL()
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.pickPhotos()
                } else {
                    
                }
            })
        }
        else if photos == .authorized {
            self.pickPhotos()
        }
        
        
        
        
        
    }
    func pickFromURL(){
        let url = URL(string: "https://pixabay.com/api/?key=17102714-02a694691583f45a98fac6bf7&q=car&image_type=photo&per_page=30")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          // your code here
            if let error = error {
              print("Error accessing swapi.co: /(error)")
              return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(response)")
              return
            }
            if let data = data,
              let pics = try? JSONDecoder().decode(PicResponse.self, from: data) {
                if let pictures = pics.hits {
                    self.urlImg = pictures.map({
                        .url(URL(string: $0.largeImageURL!)!, placeholder:UIImage())
                    })
                }
            }
        })
        task.resume()
    }
    func pickPhotos() {
        var results = NSMutableArray()
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)

        assets.enumerateObjects { (obj, idx, bool) -> Void in
            results.add(obj)
        }

        let cameraRollAssets = results.filtered(using: NSPredicate(format: "sourceType == %@", argumentArray: [1]))
        results = NSMutableArray(array: cameraRollAssets)
        
        librayImg = results.map({
            .image(getAssetThumbnail(asset: $0 as! PHAsset))
        })
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
        })
        return thumbnail
    }

    @IBAction func fromURL(_ sender: Any) {
        let gallery = GalleryViewController()
        gallery.images = urlImg
        self.navigationController?.pushViewController(gallery, animated: true)
    }
    
    @IBAction func fromPhotos(_ sender: Any) {
        if let librayImg = librayImg {
            let gallery = GalleryViewController()
            gallery.images = librayImg
            self.navigationController?.pushViewController(gallery, animated: true)
        }
    }
    
    @IBAction func fromAssetsAction(_ sender: Any) {
        let gallery = GalleryViewController()
        gallery.images = [.image(UIImage(named: "1")),
                          .image(UIImage(named: "2")),
                          .image(UIImage(named: "3")),
                          .image(UIImage(named: "4")),
                          .image(UIImage(named: "5")),
                          .image(UIImage(named: "6")),
                          .image(UIImage(named: "7")),
                          .image(UIImage(named: "8")),
                          .image(UIImage(named: "9")),
                          .image(UIImage(named: "10")),
                          .image(UIImage(named: "11")),
                          .image(UIImage(named: "12")),
                          .image(UIImage(named: "13")),
                          .image(UIImage(named: "14")),
                          .image(UIImage(named: "15"))]
        self.navigationController?.pushViewController(gallery, animated: true)
    }
    
    
}

struct PicResponse : Codable {
    let total : Int?
    let totalHits : Int?
    let hits : [Hits]?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        totalHits = try values.decodeIfPresent(Int.self, forKey: .totalHits)
        hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
    }

}
struct Hits : Codable {
    let id : Int?
    let pageURL : String?
    let type : String?
    let tags : String?
    let previewURL : String?
    let previewWidth : Int?
    let previewHeight : Int?
    let webformatURL : String?
    let webformatWidth : Int?
    let webformatHeight : Int?
    let largeImageURL : String?
    let fullHDURL : String?
    let imageURL : String?
    let imageWidth : Int?
    let imageHeight : Int?
    let imageSize : Int?
    let views : Int?
    let downloads : Int?
    let favorites : Int?
    let likes : Int?
    let comments : Int?
    let user_id : Int?
    let user : String?
    let userImageURL : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case pageURL = "pageURL"
        case type = "type"
        case tags = "tags"
        case previewURL = "previewURL"
        case previewWidth = "previewWidth"
        case previewHeight = "previewHeight"
        case webformatURL = "webformatURL"
        case webformatWidth = "webformatWidth"
        case webformatHeight = "webformatHeight"
        case largeImageURL = "largeImageURL"
        case fullHDURL = "fullHDURL"
        case imageURL = "imageURL"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
        case imageSize = "imageSize"
        case views = "views"
        case downloads = "downloads"
        case favorites = "favorites"
        case likes = "likes"
        case comments = "comments"
        case user_id = "user_id"
        case user = "user"
        case userImageURL = "userImageURL"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        pageURL = try values.decodeIfPresent(String.self, forKey: .pageURL)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        previewURL = try values.decodeIfPresent(String.self, forKey: .previewURL)
        previewWidth = try values.decodeIfPresent(Int.self, forKey: .previewWidth)
        previewHeight = try values.decodeIfPresent(Int.self, forKey: .previewHeight)
        webformatURL = try values.decodeIfPresent(String.self, forKey: .webformatURL)
        webformatWidth = try values.decodeIfPresent(Int.self, forKey: .webformatWidth)
        webformatHeight = try values.decodeIfPresent(Int.self, forKey: .webformatHeight)
        largeImageURL = try values.decodeIfPresent(String.self, forKey: .largeImageURL)
        fullHDURL = try values.decodeIfPresent(String.self, forKey: .fullHDURL)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        imageWidth = try values.decodeIfPresent(Int.self, forKey: .imageWidth)
        imageHeight = try values.decodeIfPresent(Int.self, forKey: .imageHeight)
        imageSize = try values.decodeIfPresent(Int.self, forKey: .imageSize)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        downloads = try values.decodeIfPresent(Int.self, forKey: .downloads)
        favorites = try values.decodeIfPresent(Int.self, forKey: .favorites)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        userImageURL = try values.decodeIfPresent(String.self, forKey: .userImageURL)
    }

}
