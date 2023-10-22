//
//  MyCartViewModel.swift
//  Food App
//
//  Created by alihizardere on 17.10.2023.
//

import Foundation
import RxSwift

class MyCartViewModel {
    var foods = BehaviorSubject<[FoodMyCart]>(value: [FoodMyCart]())
    var frepo = FoodDaoRepository()
    
    init(){
        foods = frepo.foods
    }
    
    func deleteItem(sepet_yemek_id:String,kullanici_adi:String){
        frepo.deleteItem(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
        DispatchQueue.main.async {
            self.frepo.bringFoodsInTheBasket(kullanici_adi: kullanici_adi)
        }
    }
    func bringFoodsInTheBasket(kullanici_adi:String){
        frepo.bringFoodsInTheBasket(kullanici_adi: kullanici_adi)
    }
}
