//
//  RBTree.swift
//  DataStruct
//
//  Created by apple on 2020/7/27.
//

import Foundation

/// 颜色
typealias Color = Bool
let red: Color = true
let black: Color = false
/// 红黑树 节点
final class RBNode<E>: BTNode<E> {
    var lChild: BTNode<E>? {
        get {
            left as? RBNode<E>
        }
        set {
            left = newValue
        }
    }
    
    var rChild: RBNode<E>? {
        get {
            right as? RBNode<E>
        }
        set {
            right = newValue
        }
    }
    
    var fater: RBNode<E>? {
        get {
            parent as? RBNode<E>
        }
        set {
            parent = newValue
        }
    }
    
    /// 颜色
    var color: Color = red
    
    /// 染色
    func render(color: Color) {
        self.color = color
    }
}


/// AVL树
public struct RBTree<E>: BST {
    
    public typealias Element = E
    /// 跟节点
    private var _root: RBNode<E>?
    public var root: BTNode<E>? {
        set {
            _root = newValue as? RBNode<E>
        }
        get {
            _root
        }
        
    }
    
    /// 比较器
    public let cmp: BSTElementCompare<E>
    
    /// 构造方法
    public init(cmp: @escaping BSTElementCompare<E>) {
        self.cmp = cmp
    }
    
    public func createNode(with val: E, parent: BTNode<E>?) -> BTNode<E> {
        RBNode(val: val, parent: parent)
    }
    
    public mutating func didInsert(_ node: BTNode<E>, parent: BTNode<E>?) {
        
    }
    public mutating func didRemoveNode(node: BTNode<E>, parent: BTNode<E>?) {
        
    }
}


/// 元素具备可比性
extension RBTree where E: Comparable {
    public init() {
        self.cmp = { (e1, e2) -> ComparisonResult in
            if e1 == e2 {
                return .orderedSame
            }
            return e1 < e2 ? .orderedAscending : .orderedDescending
        }
    }
}
