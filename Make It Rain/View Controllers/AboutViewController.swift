//
//  AboutViewController.swift
//  Make It Rain
//
//  Created by Timothy on 5/6/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {


    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = NSMutableAttributedString(string: """
            Make It Rain is an AR experience app that helps to visualize money, inducing reactions and emotions that are otherwise inhibited through the constant use of digital transactions.
            
            This is a non-profit open-source app created by Timothy Lobiak. Other projects of mine can be viewed at timothylobiak.me
            """)
        let foundRange = text.mutableString.range(of: "timothylobiak.me")
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Montserrat Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.theme.gold,
            NSAttributedString.Key.underlineColor: UIColor.theme.main,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        text.addAttribute(.link, value: "https://www.timothylobiak.me/", range: foundRange)
        text.addAttributes(attributes, range: NSRange(location: 0, length: text.length))
        
        aboutTextView.attributedText = text
        aboutTextView.linkTextAttributes = linkAttributes
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
