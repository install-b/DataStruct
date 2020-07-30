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
    var lChild: RBNode<E>? {
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
    
    /// 颜色 默认给个黑色
    var color: Color = red
    
    /// 染色
    func render(color: Color) {
        self.color = color
    }
    
    /// 堂兄弟
    var brother: RBNode<E>? {
        if isSameObject(parent?.left, self) {
           return parent?.right as? RBNode<E>
        }
        return parent?.left as? RBNode<E>
    }
    
    /// 叔节点
    var uncle: RBNode<E>? {
        guard let fater = fater else {
            return nil
        }
        return fater.brother
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
    /// 元素个数
    public private(set) var count: Int = 0
    /// 比较器
    public let cmp: BSTElementCompare<E>
    
    /// 构造方法 自定义比较
    public init(cmp: @escaping BSTElementCompare<E>) {
        self.cmp = cmp
    }
    
    
    /// 创建红黑树节点
    public func createNode(with val: E, parent: BTNode<E>?) -> BTNode<E> {
        RBNode(val: val, parent: parent)
    }
    
    /// 插入了元素 实现自平衡
    public mutating func didInsert(_ node: BTNode<E>, parent: BTNode<E>?) {
        count += 1
        /// 插入元素实现自平衡
        guard let node = node as? RBNode<E> else { return }
        guard let parent = parent as? RBNode<E> else {
            // 插入的是根节点 需要染黑
            node.color = black
            return
        }
        /// 插入的父节点是否为红色   是黑色不需要处理
        guard parent.color == red else {  return }

        balanceNode(node: node, parent: parent)
        
    }
    
    mutating func balanceNode(node: RBNode<E>, parent: RBNode<E>) {
        /// 插入的父节点是红色
        
        if let uncle = parent.brother {
            /// 叔节点是红色
            if uncle.color == red {
                parent.color = black
                uncle.color = black
                parent.fater?.color = red
                return
            }
            
        }
        // 叔节点不存在
        
        // 是否存在祖父节点
        guard let grand = parent.fater else {
            return
        }
        
        let isPleft = isSameObject(grand.left, parent)
        let isLeft = isSameObject(parent.left, node)
        if isLeft {
            if isPleft {
                /// LL型 右旋转
                makeRightRatio(grand, lChild: parent)
                /// 自己染黑
                node.color = black
                
                if let grandF = parent.fater {
                    if grandF.color == red {
                        balanceNode(node: grand, parent: grandF)
                    }
                } else {
                    parent.color = black
                }
                
            } else {
                // LR型
                makeRightRatio(parent, lChild: node)
                makeLeftRatio(grand, rChild: node)
                /// 父节点染黑
                parent.color = black
                if let grandF = node.fater {
                    if grandF.color == red {
                        balanceNode(node: node, parent: grandF)
                    }
                } else {
                    node.color = black
                }
            }
        } else {
            if isPleft {
                /// RL型 右旋转
                makeLeftRatio(parent, rChild: node)
                makeRightRatio(grand, lChild: node)
                /// 父节点染黑
                parent.color = black
                if let grandF = node.fater {
                    if grandF.color == red {
                        balanceNode(node: node, parent: grandF)
                    }
                } else {
                    node.color = black
                }
            } else {
                // RR型
                makeLeftRatio(grand, rChild: parent)
                /// 自己染黑
                node.color = black
                
                /// 判断再上父节点是否为红色
                if let grandF = parent.fater {
                    if grandF.color == red {
                        /// 继续平衡
                        balanceNode(node: grand, parent: grandF)
                    }
                } else {
                    /// 说明是跟节点 需要染成黑色
                    parent.color = black
                }
            }
        }
        
    }
    /// 移除了元素 实现自平衡
    public mutating func didRemoveNode(node: BTNode<E>, parent: BTNode<E>?) {
        count -= 1
        
    }
    
    public func printNodes() {
        guard let node = _root else { return }
        
        var nodes = [node]
        
        while !nodes.isEmpty {
            let n = nodes.removeFirst()
            if let left = n.lChild {
                nodes.append(left)
            }
            if let right = n.rChild {
                nodes.append(right)
            }
            
            print("val: \(n.val) \(n.color == red ? "♥" : "♠")")
        }
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
