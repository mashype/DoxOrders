//
//  Patient.swift
//  DoxOrders
//
//  Created by Seth Merritt on 1/9/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import Foundation


struct Patient: Decodable {
	let active: Int?
	let gender: String?
	let birthdate: String?
	let name: [Name]?
		
//		//new record init
//		init(content: String, addedByUser: String, key: String = "") {
//			self.key = key
//			self.content = content
//			self.addedByUser = addedByUser
//			self.itemRef = nil
//		}
//
//		//init to create an existing record.
//		init(snapshot:DataSnapshot) {
//			key = snapshot.key
//			itemRef = snapshot.ref
//
//			if let sweetContent = (snapshot.value as? NSDictionary)?["content"] as? String {
//				content = sweetContent
//			} else {
//				content = ""
//			}
//
//			if let sweetUser = (snapshot.value as? NSDictionary)?["addedByUser"] as? String {
//				addedByUser = sweetUser
//			} else {
//				addedByUser = ""
//			}
//		
		
}
	
struct Address: Decodable {
	let text: String?
	let city: String?
}
	
struct Telecom: Decodable {
	let system: String?
	let value: String?
	let use: String?
}

struct Name: Decodable {
	let text: String?
}
	
	
