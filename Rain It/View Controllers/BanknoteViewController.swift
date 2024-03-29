//
//  BanknoteViewController.swift
//  Make It Rain
//
//  Created by Timothy on 4/15/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit
import CenteredCollectionView

protocol BanknoteViewControllerDelegate{
    func updateView()
    func updateBackButton()
}

class BanknoteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var banknoteCollectionView: UICollectionView!
    @IBOutlet weak var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    var banknoteViewControllerDelegate: BanknoteViewControllerDelegate?
    var allCurrencies = Currency.allCurrencies
    var allImages: [UIImage] = []
    
    // MARK: - Override Presenting Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Modify the collectionView's decelerationRate
        banknoteCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        banknoteCollectionView.backgroundColor = .clear
        
        // Assign delegate and data source
        banknoteCollectionView.delegate = self
        banknoteCollectionView.dataSource = self
        
        // Configure the optional inter item spacing
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        
        // Get rid of scrolling indicators
        banknoteCollectionView.showsVerticalScrollIndicator = false
        banknoteCollectionView.showsHorizontalScrollIndicator = false
        
        // Fixes collection view layout for large screens with poor size estimation 
        banknoteCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get all Currencies
        allCurrencies = Currency.allCurrencies
        
        // Access images of all the currencies
        allImages = []
        for i in 0..<allCurrencies.count {
            let images = allCurrencies[i].getImages()
            let image = images[5] ?? images[images.keys.min()!]!
            allImages.append(image)
        }
        
        
        banknoteCollectionView.reloadData()
        let index = allCurrencies.firstIndex(of: Currency.selectedCurrency) ?? 0
        Currency.selectedCurrency = allCurrencies[index]
        self.banknoteViewControllerDelegate?.updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        banknoteCollectionView.reloadData()
        let index = allCurrencies.firstIndex(of: Currency.selectedCurrency) ?? 0
        centeredCollectionViewFlowLayout.scrollToPage(index: index+1, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Configure the required item size
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: banknoteCollectionView.bounds.width * 0.7,
            height: banknoteCollectionView.bounds.height * 0.7
        )
    }
    
    // MARK: - Collection View Setup
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return allCurrencies.count + 1}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "banknoteCell", for: indexPath) as! BanknoteCell
        
        // Check if the cell is not the one reserved for new currencies
        if (indexPath.row != 0){
            cell.banknoteImageView.image = allImages[indexPath.row - 1]
        } else {
            let image = UIImage(named: "new_currency")
            cell.banknoteImageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // check if the currentCenteredPage is not the page that was touched
        let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage
        
        if currentCenteredPage != indexPath.row {
            centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
            if (indexPath.row != 0){
                Currency.selectedCurrency = allCurrencies[indexPath.row-1]
                self.banknoteViewControllerDelegate?.updateView()
            }
        } else {
            // Tapped again
            if (indexPath.row == 0){
                let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewCurrencyViewController") as! NewCurrencyViewController
                self.banknoteViewControllerDelegate?.updateBackButton()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    // MARK: - Scroll View to Track current location
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (centeredCollectionViewFlowLayout.currentCenteredPage != 0){
            Currency.selectedCurrency = allCurrencies[centeredCollectionViewFlowLayout.currentCenteredPage!-1]
            self.banknoteViewControllerDelegate?.updateView()
        }
    }
}
