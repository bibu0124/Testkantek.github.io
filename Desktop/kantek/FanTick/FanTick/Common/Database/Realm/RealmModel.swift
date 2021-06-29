//
//  RealmModel.swift
//  KFC
//
//  Created by Dong Nguyen on 12/12/19.
//  Copyright © 2019 TVT25. All rights reserved.
//

import Foundation
import RealmSwift
func convertObjectToData(_ object: ProductModel)-> Data? {
       guard let data = try? JSONEncoder().encode(object) else {
           return nil
       }
       return data
   }
   
   func convertDataToObject(_ data: Data) -> ProductModel? {
       guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
           return nil
       }
       guard let model = dictionary.toCodableObject() as ProductModel? else{
           return nil
       }
       return model
   }



class ProductsInRealm: Object {
    @objc dynamic var key = ""
    @objc dynamic var product:Data?
    @objc dynamic var quantity = 0
    @objc dynamic var id = 0
    @objc dynamic var option_index = 0
    @objc dynamic var color_index = 0

    init(_ model: ProductModel) {
        super.init()
        id = model.id ?? 0
        quantity = model.quantity ?? 1
        product = convertObjectToData(model)
        key = model.key ?? ""
        option_index = model.optionIndex ?? 0
        color_index = model.propertieIndex ?? 0

    }    
    required init() {
        super.init()
    }
}


class Badge : Object {
    @objc dynamic var badgeValue = 0
    //    @objc dynamic var user_id = Token().getUser()?.id ?? 0
}
//
