//
//  Onboarding.swift
//  Food App
//
//  Created by alihizardere on 19.10.2023.
//

import UIKit

class Onboarding: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides = [OnboardingSlide]()
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextLabel.setTitle("Hadi Başlayalım", for: .normal)
            }else{
                nextLabel.setTitle("Sonraki", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        slides = [
            OnboardingSlide(title: "Lezzetin Yeni Adresi", description: "Lezzet dolu atıştırmalıklar ve tatlılar!", image: UIImage(named: "slide1")!),
            OnboardingSlide(title: "Profesyonel aşçılar", description: "Şeflerimizin büyülediği özel yemeklerle tanışın!", image: UIImage(named: "slide2")!),
            OnboardingSlide(title: "Hızlı servis", description: "Saniyeler içinde lezzetin keyfini çıkarın!", image: UIImage(named: "slide3")!)
        ]
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "WelcomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
}
extension Onboarding: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let slide = slides[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCell
        cell.setup(slide)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
    
    
}
