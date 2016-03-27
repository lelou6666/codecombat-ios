//
//  TomeInventoryItem.swift
//  CodeCombat
//
//  Created by Michael Schmatz on 8/6/14.
//  Copyright (c) 2014 CodeCombat. All rights reserved.
//

class TomeInventoryItem {
  let itemData: JSON
  var properties: [TomeInventoryItemProperty] = []
  var name: String {
    return itemData["name"].toString(false)
  }
  var imageURL: NSURL {
    var url: String = itemData["imageURL"].toString(false)
    if url.isEmpty {
      url = "/file/db/thang.type/53e4108204c00d4607a89f78/programmicon.png"
    }
    return NSURL(string: url, relativeToURL: rootURL)!
  }
  
  init(itemData: JSON) {
    self.itemData = itemData
  }
  
  convenience init(itemData: JSON, propertiesData: JSON) {
    self.init(itemData: itemData)
    for (_, prop) in itemData["programmableProperties"] {
      for (_, anotherProp) in propertiesData {
        if anotherProp["name"].asString! == prop.asString! {
          properties.append(TomeInventoryItemProperty(propertyData: anotherProp, primary: true))
          break
        }
      }
    }
    for (_, prop) in itemData["moreProgrammableProperties"] {
      for (_, anotherProp) in propertiesData {
        if anotherProp["name"].asString! == prop.asString! {
          properties.append(TomeInventoryItemProperty(propertyData: anotherProp, primary: false))
          break
        }
      }
    }
  }
  
  func addProperty(property: TomeInventoryItemProperty) {
    properties.append(property)
  }
  
  func removeAllProperties() {
    properties.removeAll(keepCapacity: true)
  }
}
