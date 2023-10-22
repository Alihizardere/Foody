//
//  HomepageViewModel.swift
//  Food App
//
//  Created by alihizardere on 17.10.2023.
//

import Foundation
import RxSwift

class HomepageViewModel {
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    var frepo = FoodDaoRepository()
    
    init(){
        foodList = frepo.foodList
    }
    
    func searchFood(searchText:String){
        frepo.searchFood(searchText: searchText)
    }
    
    func loadTheFoods(){
        frepo.loadTheFoods()
    }
}
