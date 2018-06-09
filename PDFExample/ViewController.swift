//
//  ViewController.swift
//  PDFExample
//
//  Created by Eugene Lezov on 08.06.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    // MARK: - Constants
    
    let baseURLString = "https://www.google.com"
    
    let base64String = /* Your base64 string */

    // MARK: - Actions
    
    @IBAction func shareDidTapped(_ sender: Any) {
        if let fileURL = saveBase64StringToPDF(base64String) {
            let objectsToShare = [fileURL]
            let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            let excludedActivities = [UIActivityType.message,
                                      UIActivityType.mail,
                                      UIActivityType.print,
                                      UIActivityType.addToReadingList]
            
            activityController.excludedActivityTypes = excludedActivities
            
            DispatchQueue.main.async {
                 self.present(activityController, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - LifeCycle Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.showPDFFile(base64PDF: base64String)
    }
    
    
    // MARK: - Private Methods
    
    private func showPDFFile(base64PDF: String) {
        let webView = WKWebView(frame: self.view.frame)

        // If you want use pdf from file
        /*guard let url = saveBase64StringToPDF(base64PDF)
            else { return }
        let urlRequest = URLRequest.init(url: url)
         webView.load(urlRequest)*/
        
        guard let data = makePDFDataFromBase64(base64PDF),
            let url = URL(string: baseURLString)
            else { return }
        
        webView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: url)
        
        self.view.addSubview(webView)
        
    }
    
    private func makePDFDataFromBase64(_ base64String: String) -> Data? {
        return Data(base64Encoded: base64String)
    }
    
    private func saveBase64StringToPDF(_ base64String: String) -> URL? {
        guard
            var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
            let convertedData = Data(base64Encoded: base64String)
            else {
                //handle error when getting documents URL
                return nil
        }
        
        //name your file however you prefer
        documentsURL.appendPathComponent("REBAccountStatement.pdf")
        
        do {
            try convertedData.write(to: documentsURL)
        } catch {
            //handle write error here
            return nil
        }
        
        //if you want to get a quick output of where your
        //file was saved from the simulator on your machine
        //just print the documentsURL and go there in Finder
        print(documentsURL)
        return documentsURL
    }


}


