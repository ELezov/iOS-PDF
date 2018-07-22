//
//  PDFHelper.swift
//  PDFExample
//
//  Created by Eugene Lezov on 22.07.18.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation
import WebKit

class PDFHelper {
    
    enum Constants {
        static let defaultUrl = "https://www.default.com"
        static let mimeTypePDF = "application/pdf"
        static let defaultNamePDFFile = "pdfFile.pdf"
    }
    
    static func makeWebView(base64String: String, frame: CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        
        guard let data = base64String.base64ToData(),
            let url = URL(string: Constants.defaultUrl)
            else { return nil }
        
        webView.load(data, mimeType: Constants.mimeTypePDF, characterEncodingName: "", baseURL: url)
        return webView
    }
    
    static func makeWebViewWithSaveFile(base64String: String, frame: CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        
        // If you want use pdf from file
        guard let url = self.saveBase64StringToPDF(base64String)
            else { return nil }
        let urlRequest = URLRequest.init(url: url)
        webView.load(urlRequest)
        return webView
    }
    
   
    
    static func saveBase64StringToPDF(_ base64String: String) -> URL? {
        guard
            var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
            let convertedData = Data(base64Encoded: base64String)
            else {
                //handle error when getting documents URL
                return nil
        }
        
        //name your file however you prefer
        documentsURL.appendPathComponent(Constants.defaultNamePDFFile)
        
        do {
            try convertedData.write(to: documentsURL)
        } catch {
            //handle write error here
            return nil
        }
        
        return documentsURL
    }
}


extension String {
    func base64ToData() -> Data? {
        return Data(base64Encoded: self)
    }
}
