//
//  RootViewController.swift
//  oldiphone
//
//  Created by Sergey Lagner on 24.06.2021.
//

import UIKit
import PlatformMapSDK


class RootViewController: UIViewController {
	
	private lazy var apiKeys: APIKeys = {
		
		let dirKey = ""
		let mapKey = ""
		guard let apiKeys = APIKeys(directory: dirKey, map: mapKey)
		else {
			fatalError("2GIS API keys are missing or invalid. Check Info.plist")
		}
		return apiKeys
	}()

	private lazy var sdk = PlatformMapSDK.Container(
		apiKeys: self.apiKeys,
		httpOptions: HTTPOptions(timeout: 15, cacheOptions: nil))
	
	private lazy var mapFactory = self.sdk.makeMapFactory(options: .default)
	private var cancelable: PlatformMapSDK.Cancellable? = nil

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.addSubview(self.mapFactory.mapView)
		
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		self.mapFactory.mapView.frame = self.view.bounds
	}


	override func viewDidAppear(_ animated: Bool) {
		Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { timer in
			self.move(index: 3)
		}
	}
	
	func move(index: Int) {
		let points = [
			CameraPosition(point: GeoPoint(latitude: Arcdegree(value: 55.1), longitude: Arcdegree(value: 37.0)), zoom: Zoom(value: 11)),
			CameraPosition(point: GeoPoint(latitude: Arcdegree(value: 50.1), longitude: Arcdegree(value: 37.0)), zoom: Zoom(value: 14)),
			CameraPosition(point: GeoPoint(latitude: Arcdegree(value: 55.1), longitude: Arcdegree(value: 39.0)), zoom: Zoom(value: 9)),
		]
		
		let newPoint = points[(index % points.count)]
		
		let future = mapFactory.map.camera.move(
			position: newPoint,
			time: 5,
			animationType: .linear
		)
		
		self.cancelable = future.sink { result in
			self.move(index: index + 1)
		} failure: { future in
			
		}
	}
}
