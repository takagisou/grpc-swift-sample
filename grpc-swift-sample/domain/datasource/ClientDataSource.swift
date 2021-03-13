//
//  ClientDataSource.swift
//  grpc-swift-sample
//
//  Created by sana on 2021/03/13.
//

import Foundation
import RxSwift
import GRPC
import HelloGRPC

protocol ClientRepository {
    func hello(name: String) -> Single<HelloEntity>
}

class ClientDataSource: ClientRepository {
    
    func hello(name: String = "strange") -> Single<HelloEntity> {
        return .create { observer -> Disposable in
                        
            // setup client
            let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
            let channel = ClientConnection
                .insecure(group: group)
                .connect(host: "localhost", port: 50051)
            let greeter = Helloworld_GreeterClient(channel: channel)

            // setup request
            let request = Helloworld_HelloRequest.with {
                $0.name = name
            }
            let sayHello = greeter.sayHello(request)
            
            do {
                let response = try sayHello.response.wait()
                let entity = HelloEntity(message: response.message)
                observer(.success(entity))
            } catch {
                observer(.failure(error))
            }

            return Disposables.create {
                try! group.syncShutdownGracefully()
                try! channel.close().wait()
            }
        }
    }
}
