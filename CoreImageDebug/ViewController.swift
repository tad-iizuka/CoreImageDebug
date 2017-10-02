//
//  ViewController.swift
//  CoreImageDebug
//
//  Created by Tadashi on 2017/10/02.
//  Copyright © 2017 UBUNIFU Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!

	var images: [CIImage] = []
	let NUM = 8

	override func viewDidLoad() {
		super.viewDidLoad()

		for _ in 0..<NUM {
			let url = URL(fileURLWithPath: Bundle.main.path(forResource: "10", ofType: "dng")!)
			let f = CIFilter(imageURL: url, options:nil)
			self.images.append(f!.outputImage!)
		}

		var image: CIImage!
		let context = CIContext(options: nil)
		let f = CIFilter(name: "CIOverlayBlendMode")
		image = self.images[0]
		let colorSpace = image.colorSpace
		for i in 1..<self.images.count {
			f?.setValue(image, forKey: kCIInputImageKey)
			f?.setValue(self.images[i], forKey: kCIInputBackgroundImageKey)
			image = f?.outputImage
		}
		let jpeg = context.jpegRepresentation(of: image!, colorSpace: colorSpace!, options: [:])
		DispatchQueue.main.async {
			self.imageView.image = UIImage.init(data: jpeg!)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

