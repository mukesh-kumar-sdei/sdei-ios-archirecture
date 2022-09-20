//
//  BaseViewController.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 27/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private var vSpinner:SwiftSpinner?
   
    var baseViewModel:BaseViewModel? {
        didSet{
            self.setUpClosure()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.configureNavigationBar()
    }
    
    private func setUpClosure() {
        
        // Closure to change hide/show loader based on isLoading
        baseViewModel?.onLoading = { [weak self] () in
            let isLoaidng = self?.baseViewModel?.isLoading ?? false
            let _ = isLoaidng ? self?.showLoader() : self?.hideLoader()
        }
        
        // Closure to show API response error
        baseViewModel?.onError = { [weak self] (error) in
            // Display error here
            SwiftAlert.show(self, title: "", message: error.localizedDescription)
        }
    }
    
    
    func showLoader() {
       
        let spinnerView = SwiftSpinner(frame: self.view.bounds)
        DispatchQueue.main.async {
            self.view.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController {
    
    // MARK: - Add back button with custom image
    func addBackButton(with name:String = "back_arrow") {
        let backButtonImage = UIImage(named: name)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: backButtonImage,
                                      style: .plain,
                                      target: self,
                                      action: #selector(onLeftBarButtonClicked(_ :)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    // MARK: - Override this function if want to change back button behaviour
    @objc func onLeftBarButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func hideNavigationBar(_ hide: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hide, animated: animated)
    }
    
    func configureNavigationBar() {
        guard let navigationController = navigationController,
            let flareGradientImage = CAGradientLayer.primaryGradient(navigationController.navigationBar, primaryColor: Color.Primary, secondaryColor: Color.Secondary)  else { return }

        navigationController.navigationBar.barTintColor = UIColor(patternImage: flareGradientImage)
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Font.Regular.of(size: 18.0)
        ]
        navigationController.navigationBar.titleTextAttributes = attrs
        
    }
}
