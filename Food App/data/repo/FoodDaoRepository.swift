//
//  FoodDaoRepository.swift
//  Food App
//
//  Created by alihizardere on 17.10.2023.
//

import Foundation
import Alamofire
import RxSwift

class FoodDaoRepository {
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    var foods = BehaviorSubject<[FoodMyCart]>(value: [FoodMyCart]())
    
    func deleteItem(sepet_yemek_id:String,kullanici_adi:String){
        //http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php
        let params = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let rs = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("-----DELETE------")
                    print(rs.message!)
                    print(rs.success!)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    func bringFoodsInTheBasket(kullanici_adi:String){
        let params = ["kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post, parameters: params).response {response in
            if let data = response.data {
                do{
                    let rs = try JSONDecoder().decode(FoodMyCartResponse.self, from: data)
                    if let list = rs.sepet_yemekler{
                        self.foods.onNext(list)
                        print(list)
                        print(data)
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
}
    
    
    func addToCart(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:String, yemek_siparis_adet:String, kullanici_adi:String){
        let params = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response {
            response in
            if let data = response.data {
                do{
                    let rs = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("--------ADD------")
                    print("Başarı : \(rs.success!)")
                    print("Başarı : \(rs.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func searchFood(searchText:String){
        let params = ["yemek_adi": searchText]

        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do {
                    let rs = try JSONDecoder().decode(FoodResponse.self, from: data)
                    if let list = rs.yemekler {
                        self.foodList.onNext(list)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadTheFoods(){
         AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response {response in
             
             if let data = response.data {
                 do{
                     let rs = try JSONDecoder().decode(FoodResponse.self, from: data)
                     if let list = rs.yemekler {
                         self.foodList.onNext(list)
                     }
                 }catch{
                     print(error.localizedDescription)
                 }
             }
         }
         
     }
    
}
