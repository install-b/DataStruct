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
    private(set) var color: Color = red
    
    /// 染色
    func render(color: Color) {
        if parent == nil, color == red {
            self.color = black
            return
        }
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
    
    override var nodeDesc: String {
        return "\(color == red ? "❤️" : "♠️") \(val) "
    }
}


/// 红黑树
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
            node.render(color: black)
            return
        }
        /// 插入的父节点是否为红色   是黑色不需要处理
        guard parent.color == red else {  return }
        /// 自平衡
        balanceNode(node: node, parent: parent)
        
    }
    
    mutating func balanceNode(node: RBNode<E>, parent: RBNode<E>) {
        /// 插入的父节点是红色
        
        if let uncle = parent.brother {
            /// 叔节点是红色
            if uncle.color == red {
                parent.render(color: black)
                uncle.render(color: black)
                if let grand = parent.fater {
                    grand.render(color: red)
                    if let grandF = grand.fater, grandF.color == red {
                        balanceNode(node: grand, parent: grandF)
                    }
                }
                

                return
            }
            
        }
        // 叔节点不存在
        
        // 是否存在祖父节点
        guard let grand = parent.fater else {
            // 不存在
            if parent.color == red {
                print("根节点变成了红节点")
            }
            guard let brother = node.brother, brother.color == black else {
                parent.render(color: black)
                return
            }
            
            
            return
        }
        
        let isPleft = isSameObject(grand.left, parent)
        let isLeft = isSameObject(parent.left, node)
        var upNode = parent
        
        if isLeft {
            if isPleft {
                /// LL型 右旋转
                makeRightRatio(grand, lChild: parent)
                /// 父节点染黑
                upNode = parent
            } else {
                // LR型
                makeRightRatio(parent, lChild: node)
                makeLeftRatio(grand, rChild: node)
                /// 自己染黑
                upNode = node
            }
        } else {
            if isPleft {
                /// RL型 右旋转
                makeLeftRatio(parent, rChild: node)
                makeRightRatio(grand, lChild: node)
                /// 自己染黑
                upNode = node
            } else {
                // RR型
                makeLeftRatio(grand, rChild: parent)
                /// 父节点染黑
                upNode = parent
            }
        }
        /// 自己染黑
        upNode.render(color: black)
        upNode.lChild?.render(color: red)
        upNode.rChild?.render(color: red)
        if let grandF = upNode.fater {
            if grandF.color == red {
                balanceNode(node: upNode, parent: grandF)
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
            
            print("val:\(n.color == red ? "❤️" : "♠️") \(n.val) ")
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
