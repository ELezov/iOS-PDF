//
//  ActivityHelper.swift
//  PDFExample
//
//  Created by Eugene Lezov on 22.07.18.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit
import WebKit

class ActivityHelper  {
    
    enum Constants {
        static let excludedPdfActivities = [UIActivityType.message,
                                  UIActivityType.mail,
                                  UIActivityType.print,
                                  UIActivityType.addToReadingList]
    }
    
    static func pdfActivityController(url: URL) -> UIActivityViewController {
        let objectsToShare = [url]
        let activityController =
            UIActivityViewController(activityItems: objectsToShare,
                                     applicationActivities: nil)
        
       
        
        activityController.excludedActivityTypes = Constants.excludedPdfActivities
        return activityController
    }
    
}
