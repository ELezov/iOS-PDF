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
    
    let base64String = /* Your base64 string */

    // MARK: - Actions
    
    @IBAction func shareDidTapped(_ sender: Any) {
        if let fileURL = PDFHelper.saveBase64StringToPDF(base64String) {
            let activityController = ActivityHelper.pdfActivityController(url: fileURL)
            
            DispatchQueue.main.async {
                 self.present(activityController, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - Life cycle Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPDFFile(base64PDF: base64String)
    }
    
    
    // MARK: - Private Methods
    
    private func showPDFFile(base64PDF: String) {
        guard let webView = PDFHelper.makeWebView(base64String: base64PDF, frame: self.view.frame)
            else { return }
        self.view.addSubview(webView)
    }


}


