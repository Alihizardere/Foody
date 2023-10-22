//
//  ViewController.swift
//  Food App
//
//  Created by alihizardere on 12.10.2023.
//

import UIKit
import Alamofire
import Kingfisher
import RxSwift

class Homepage: UIViewController {
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let imageBaseURL = "http://kasimadalan.pe.hu/yemekler/resimler/"
    var foodList = [Foods]()
    var viewModel = HomepageViewModel()
    var searchedFoodList = [Foods]()
    var searchedWord: String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        searchBar.delegate = self
        
        _ = viewModel.foodList.subscribe(onNext:{ list in
            self.foodList = list
            DispatchQueue.main.async {
                self.foodCollectionView.reloadData()
            }
        })
        //Collectionview Tasarım
        let design  = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 15
        
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth-45)/2
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth*1.3)
        foodCollectionView.collectionViewLayout = design
       
        //Tabbar
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.backgroundColor = UIColor.white
        
        changeColor(itemAppearance: appearanceTabBar.stackedLayoutAppearance)
        changeColor(itemAppearance: appearanceTabBar.inlineLayoutAppearance)
        changeColor(itemAppearance: appearanceTabBar.compactInlineLayoutAppearance)
        
        tabBarController?.tabBar.standardAppearance = appearanceTabBar
        tabBarController?.tabBar.scrollEdgeAppearance = appearanceTabBar
        
        //NavBar
        self.navigationItem.title = "FOODY"
        self.navigationItem.hidesBackButton = true
        
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.titleTextAttributes = [.foregroundColor: UIColor.systemOrange, .font: UIFont(name: "Marker Felt", size: 33.0)!]
   
        navigationController?.navigationBar.standardAppearance = appearanceNavBar
         navigationController?.navigationBar.compactAppearance = appearanceNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNavBar

    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadTheFoods()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let food = sender as? Foods {
                let goToVC = segue.destination as! FoodDetail
                goToVC.food = food
            }
        }
    }
    
    func changeColor(itemAppearance: UITabBarItemAppearance){
        //Selected
        itemAppearance.selected.iconColor = UIColor.systemOrange
        itemAppearance.selected.titleTextAttributes = [.foregroundColor:UIColor.systemOrange]
        
        //Unselected
        itemAppearance.normal.iconColor = UIColor.lightGray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
    }
}

extension Homepage : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedWord = searchText
        searchedFoodList = foodList.filter({$0.yemek_adi?.lowercased().contains(searchText.lowercased()) ?? false})
        self.viewModel.searchFood(searchText: searchText)
        foodCollectionView.reloadData()
    }
    
    func getListCount() -> Int{
        return workingList().count
    }
    
    func getSearching(for indexPath: IndexPath) -> Foods {
        return workingList()[indexPath.row]
    }
    
    func workingList() -> [Foods]{
        if searchedWord.count == 0{
            return foodList
        }else{
            return searchedFoodList
        }
    }
}

extension Homepage : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  getListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let food = getSearching(for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        cell.labelFoodName.text = food.yemek_adi
        cell.labelFoodPrice.text = "\(food.yemek_fiyat!)₺"
        if let url =  URL(string: "\(imageBaseURL)\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.labelFoodImage.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = getSearching(for: indexPath)
        performSegue(withIdentifier: "toDetail", sender: food)
    }
}
