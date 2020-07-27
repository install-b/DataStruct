//
//  AVLTree.swift
//  DataStruct
//
//  Created by apple on 2020/7/27.
//

import Foundation

/// AVL 树 节点
final class AVLNode<E>: BTNode<E> {
    var lChild: AVLNode<E>? {
        get {
            left as? AVLNode<E>
        }
        set {
            left = newValue
        }
    }
    
    var rChild: AVLNode<E>? {
        get {
            right as? AVLNode<E>
        }
        set {
            right = newValue
        }
    }
    
    var fater: AVLNode<E>? {
        get {
            parent as? AVLNode<E>
        }
        set {
            parent = newValue
        }
    }
    
    // 高度 默认为一层 左右子树为空
    var height = 1
    
    /// 平衡因子
    var factor: Int {
        (lChild?.height ?? 0) - (rChild?.height ?? 0)
    }
    
    /// 更新高度
    func updateHight() {
        height = max(lChild?.height ?? 0, rChild?.height ?? 0) + 1
        fater?.updateHight()
    }
    
    override init(val: E, parent: BTNode<E>? = nil, left: BTNode<E>? = nil, right: BTNode<E>? = nil) {
        super.init(val: val, parent: parent, left: left, right: right)
        updateHight()
    }
}


/// AVL树 
public struct AVLTree<E>: BST {
    public typealias Element = E
    /// 跟节点
    private var _root: AVLNode<E>?
    public var root: BTNode<E>? {
        set {
            _root = newValue as? AVLNode<E>
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
        AVLNode(val: val, parent: parent)
    }
    
    public mutating func didInsert(_ node: BTNode<E>, parent: BTNode<E>, isLeft: Bool) {
        guard let node = node as? AVLNode<E>, let parent = parent as? AVLNode<E> else { return }
        node.updateHight()
        
        guard let grand = parent.fater else { return }
        if -1...1 ~= grand.factor { return }
        
        if isSameObject(grand.lChild, parent) {
            if isLeft {
                /// LL 型
                /// 进行一个右旋转
                makeRightRatio(grand, lChild: parent)
            } else {
                // LR 型
                
            }
        } else {
            if isLeft {
                //RL 型
                
            } else {
                // RR 型
                
            }
        }
    }
}

/// 元素具备可比性
extension AVLTree where E: Comparable {
    public init() {
        self.cmp = { (e1, e2) -> ComparisonResult in
            if e1 == e2 {
                return .orderedSame
            }
            return e1 < e2 ? .orderedAscending : .orderedDescending
        }
    }
}
