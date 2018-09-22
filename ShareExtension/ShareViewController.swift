//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by pankaj on 22/09/18.
//  Copyright © 2018 Pankaj. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        return true
    }

    override func didSelectPost() {
        
        var arrSharedItems:NSMutableDictionary = [:]
        
        let userDefault = UserDefaults(suiteName: "group.Pankaj.shareKitDemo")
        if userDefault?.object(forKey: "SharedArray") as? [NSDictionary] != nil  {
            arrSharedItems = userDefault?.object(forKey: "SharedArray") as! NSMutableDictionary
        }
        
        if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem{
            for ele in item.attachments!{
                let itemProvider = ele as! NSItemProvider
                // public.image - public.jpeg
                if itemProvider.hasItemConformingToTypeIdentifier("public.image"){
                    NSLog("itemprovider: %@", itemProvider)
                    itemProvider.loadItem(forTypeIdentifier: "public.image", options: nil, completionHandler: { (item, error) in
                        
                        var imgData: Data!
                        if let url = item as? URL {
                            imgData = try! Data(contentsOf: url)
                        }
                        
                        if let img = item as? UIImage {
                            imgData = UIImagePNGRepresentation(img)
                        }
                        
                        let dict: [String : Any] = ["imgData" :  imgData, "name" : self.contentText]
//                        let userDefault = UserDefaults.standard
//                        userDefault.addSuite(named: "group.Pankaj.shareKitDemo")
                        arrSharedItems.setObject(dict, forKey: "img" as NSCopying)
//                        userDefault.set(dict, forKey: "img")
//                        userDefault.synchronize()
                    })
                }
                
                if itemProvider.hasItemConformingToTypeIdentifier("public.plain-text"){
                    NSLog("itemprovider: %@", itemProvider)
                    itemProvider.loadItem(forTypeIdentifier: "public.plain-text", options: nil, completionHandler: { (item, error) in
                        
//                        var imgData: Data!
//                        if let url = item as? URL{
//                            imgData = try! Data(contentsOf: url)
//                        }
//
//                        if let img = item as? UIImage{
//                            imgData = UIImagePNGRepresentation(img)
//                        }
                        
                        let strText = item as! String
                        
                        let dict: [String : Any] = ["text" :  strText, "name" : self.contentText]
                        arrSharedItems.setObject(dict, forKey: "txt" as NSCopying)

//                        let userDefault = UserDefaults.standard
//                        userDefault.addSuite(named: "group.Pankaj.shareKitDemo")
//                        userDefault.set(dict, forKey: "txt")
//                        userDefault.synchronize()
                    })
                }
                if itemProvider.hasItemConformingToTypeIdentifier("public.url"){
                    NSLog("itemprovider: %@", itemProvider)
                    itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (item, error) in
                        
                        let urlText = item as! URL
                        let dict: [String : Any] = ["url" :  urlText, "name" : self.contentText]
                        arrSharedItems.setObject(dict, forKey: "URL" as NSCopying)

//                        let userDefault = UserDefaults.standard
//                        userDefault.addSuite(named: "group.Pankaj.shareKitDemo")
//                        userDefault.set(dict, forKey: "URL")
//                        userDefault.synchronize()
                    })
                    
                   /* NSDictionary *dictSite = [NSDictionary dictionaryWithObjectsAndKeys:self.contentText, @"Text", url.absoluteString, @"URL",nil];
                    [arrSites addObject:dictSite];
                    [sharedUserDefaults setObject:arrSites forKey:@"SharedExtension"];
                    [sharedUserDefaults synchronize];*/
                }

            }
            userDefault?.set(arrSharedItems, forKey: "SharedArray")
            userDefault?.synchronize()
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    override func configurationItems() -> [Any]! {
        return []
    }

}
