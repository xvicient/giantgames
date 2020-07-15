//
//  DependencyInjection.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Swinject

protocol DependencyInjectionApi {
    func resolve<Service>(_ serviceType: Service.Type) -> Service
    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service
    func resolve<Service>(_ serviceType: Service.Type, resetObjectScope: Bool) -> Service
    func clear()
}

protocol Dependencies {
    func register(_ container: Container)
}

enum DependencyInjectionFactory {
    static func make(_ dependencies: Dependencies) -> DependencyInjectionApi {
        DependencyInjection(dependencies: dependencies)
    }
}

extension ObjectScope {
    static let resettable = ObjectScope(storageFactory: PermanentStorage.init)
    static let unclearable = ObjectScope(storageFactory: PermanentStorage.init)
}

struct DependencyInjection: DependencyInjectionApi {
    let container: Container
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        container = Container()
        self.dependencies = dependencies
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        if let service = container.synchronize().resolve(serviceType) {
            return service
        } else {
            dependencies.register(container)
            return container.synchronize().resolve(serviceType)!
        }
    }
    
    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        if let service = container.synchronize().resolve(serviceType, argument: argument) {
            return service
        } else {
            dependencies.register(container)
            return container.synchronize().resolve(serviceType)!
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type, resetObjectScope: Bool) -> Service {
        if resetObjectScope { container.resetObjectScope(.resettable) }
        return resolve(serviceType)
    }
    
    func clear() {
        container.resetObjectScope(.graph)
        container.resetObjectScope(.container)
        container.resetObjectScope(.resettable)
    }
}

struct DependenciesRegistration: Dependencies {
    func register(_ container: Container) {
        registerFoundation(container)
        registerServices(container)
    }
    
    func registerFoundation(_ container: Container) {
        container.register(URLSessionConfiguration.self) { _ in
            URLSessionConfiguration.default
        }
        container.register(URLSession.self) {
            URLSession(configuration: $0.resolve(URLSessionConfiguration.self)!)
        }
    }
    
    func registerServices(_ container: Container) {
        #if DEBUG
            container.register(APIClientLoggerApi.self) { _ in
                APIClientLoggerFactory.make()
            }
        #endif

        container.register(APIClientApi.self) {
            APIClientFactory.make(baseURL: "https://api-v3.igdb.com/",
                                  session: $0.resolve(URLSession.self)!,
                                  logger: $0.resolve(APIClientLoggerApi.self))
        }

        container.register(GameServiceApi.self) {
            GameService(apiClient: $0.resolve(APIClientApi.self)!)
        }

        container.register(GameImageServiceApi.self) {
            GameImageService(apiClient: $0.resolve(APIClientApi.self)!)
        }

        container.register(GameVideoServiceApi.self) {
            GameVideoService(apiClient: $0.resolve(APIClientApi.self)!)
        }
    }
}
