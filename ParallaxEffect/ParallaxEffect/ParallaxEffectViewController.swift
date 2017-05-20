//
//  ParallaxEffectViewController.swift
//  ParallaxEffect
//
//  Created by Tiago Pereira on 20/05/2017.
//  Copyright © 2017 Tiago Pereira. All rights reserved.
//

import UIKit

class ParallaxEffectViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var parallaxEffectView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var touchableView: UIView!
    
    // MARK: - Properties
    
    private let offset: Float = 20
    
    fileprivate let reuseIdentifier = "DummyAppCollectionViewCell"
    
    fileprivate var appImages = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "11"), UIImage(named: "12"), UIImage(named: "13"), UIImage(named: "14"), UIImage(named: "15"), UIImage(named: "16"), UIImage(named: "17"), UIImage(named: "18"), UIImage(named: "19"), UIImage(named: "20"), UIImage(named: "21"), UIImage(named: "22"), UIImage(named: "23"), UIImage(named: "24")]
    
    let tapGesture = UITapGestureRecognizer()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image: UIImage = UIImage(named: "background") else {
            return
        }
        
        backgroundImageView.image = image
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DummyAppCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // DOUBLE TAP
        tapGesture.addTarget(self, action: #selector(ParallaxEffectViewController.hideOrShowIcons))
        touchableView.isUserInteractionEnabled = true
        touchableView.addGestureRecognizer(tapGesture)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Utils
    func hideOrShowIcons() {
        
        var newAlpha: CGFloat = 0
        
        if collectionView.alpha == 0 {
            newAlpha = 1.0
        }
        
        UIView.animate(withDuration: 0.25) { 
            self.collectionView.alpha = newAlpha
        }
        
    }
    
    //MARK: - Parallax Effect
    
    func addParallaxToView(view: UIView, offset: Float) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -offset
        horizontal.maximumRelativeValue = offset
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -offset
        vertical.maximumRelativeValue = offset
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        view.addMotionEffect(group)
    }
    
    func removeEffectsInView(view: UIView) {
        for effect in view.motionEffects {
            view.removeMotionEffect(effect)
        }
    }
    
    @IBAction func segmentedControleValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.removeEffectsInView(view: parallaxEffectView)
        }
        else {
            self.addParallaxToView(view: parallaxEffectView, offset: offset)
        }
    }
    
}

extension ParallaxEffectViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DummyAppCollectionViewCell
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! DummyAppCollectionViewCell
        cell.dummyAppImageView.image = appImages[indexPath.row]
    }
}

