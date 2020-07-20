//
//  Optional+GG.swift
//  GiantGames
//
//  Created by Xavier on 20/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Bool {
    var safeBool: Bool {
        return self ?? false
    }
}

extension Optional {
    var isNil: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Any {
    var toString: String {
        guard let value = self else {
            return ""
        }
        return String(describing: value)
    }
}

extension Optional where Wrapped == Int {
    var toString: String {
        guard let value = self else {
            return ""
        }
        return String(value)
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        return self ?? 0
    }
}

protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

extension Occupiable {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension String: Occupiable {}
extension Array: Occupiable {}
extension Dictionary: Occupiable {}
extension Set: Occupiable {}

extension Optional where Wrapped: Occupiable {
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case let .some(value):
            return value.isEmpty
        }
    }

    var isNotNilNotEmpty: Bool {
        return !isNilOrEmpty
    }
}

public protocol EmptyValueRepresentable {
    static var emptyValue: Self { get }
    var isEmpty: Bool { get }
}

extension EmptyValueRepresentable {
    public func nilIfEmpty() -> Self? {
        return isEmpty ? nil : self
    }
}

extension Array: EmptyValueRepresentable {
    public static var emptyValue: [Element] { return [] }
}

extension Set: EmptyValueRepresentable {
    public static var emptyValue: Set<Element> { return Set() }
}

extension Dictionary: EmptyValueRepresentable {
    public static var emptyValue: [Key: Value] { return [:] }
}

extension String: EmptyValueRepresentable {
    public static var emptyValue: String { return "" }
}

public extension Optional where Wrapped: EmptyValueRepresentable {
    var valueOrEmpty: Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }
}
