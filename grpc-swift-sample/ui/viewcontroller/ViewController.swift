//
//  ViewController.swift
//  grpc-swift-sample
//
//  Created by sana on 2021/03/13.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    private let disposeBag = DisposeBag()
    private let clientRepository: ClientRepository = ClientDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clientRepository.hello(name: "Swift")
            .observe(on: MainScheduler.instance)
            .subscribe { [unowned self] entity in
                self.label.text = entity.message
            } onFailure: { [unowned self] error in
                self.label.text = "gRPC failed! \(error)"
            }.disposed(by: disposeBag)

    }
}

