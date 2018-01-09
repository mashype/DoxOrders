//
//  ViewController.swift
//  DoxOrders
//
//  Created by Seth Merritt on 1/9/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import AeroGearHttp
import AeroGearOAuth2
import Alamofire
import WebKit

let base = "https://tw171.open.allscripts.com/FHIR/Patient/19"
let authzEndpoint = "https://tw171.open.allscripts.com/authorization/connect/authorize"
let redirectURL = "doxOrders://?aParam=paramVal"
let tokenEndpoint = "https://tw171.open.allscripts.com/authorization/connect/token"
let clientID = "9af942de-1116-4958-9711-0fc4dff355d7"
let scopes = ["launch openid profile"]


let allscriptsConfig = Config(base: base, authzEndpoint: authzEndpoint, redirectURL: redirectURL, accessTokenEndpoint: tokenEndpoint, clientId: clientID, scopes: scopes)
let gdModule = AccountManager.addAccountWith(config: allscriptsConfig, moduleClass: OAuth2Module.self)

let url = "https://tw171.open.allscripts.com/FHIRanon/Patient/19" //allscripts test
let callURL = "https://tw171.open.allscripts.com/FHIRanon/Patient/19"
//let url = "https://fhir-open.sandboxcerner.com/dstu2/0b8a0111-e8e6-4c26-a91c-5069cbc6b1ca/Condition?patient=4342012" //cerner test

//let params = ["location" : "San Diego, CA" ]
let headers = ["Accept" : "application/json+fhir", "Authorization" : "<OAuth2 Bearer Token>"]

var http = Http()

class ViewController: UIViewController {
	
	@IBAction func requestAuth(_ sender: Any) {
		http.authzModule = gdModule
		gdModule.requestAccess { (response, error) in
			if response != nil {
				print("RESPONSE", response!)
			} else {
				print("ERR", error!)
			}
		}
	}
	
	
	@IBAction func callPatient(_ sender: Any) {
	
		Alamofire.request(callURL, method: .get, parameters: nil, headers: headers).responseJSON { (response) in
			if let JSON = response.result.value {
				print("RESULT", JSON)
			} else {
				print(response.error!)
			}
		}
		
		guard let finalURL = URL(string: url) else { return }
		URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
			guard let data = data else { return }
			
			do {
				let patientInfo = try JSONDecoder().decode(Patient.self, from: data)
				print("DATA", data)
				print("TEST INFO", patientInfo)
			} catch let jsonErr {
				print("JSON ERR:", jsonErr)
			}
		}.resume()
		
//		self.http = Http()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

