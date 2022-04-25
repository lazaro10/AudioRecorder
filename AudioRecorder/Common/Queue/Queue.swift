import Foundation

class Node<T>: CustomStringConvertible {
    var value: T
    var next: Node?

    var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }

    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct QueueIterator<T>: IteratorProtocol {
    private let database: Queue<T>
    private var index = 0

    mutating func next() -> T? {
        defer {
            self.index += 1
        }

        guard index < database.count else {
            return nil
        }

        var head = database.head
        var value: T?

        for _ in 0...index {
            value = head?.value
            head = head?.next
        }

        return value
    }

    init(database: Queue<T>) {
        self.database = database
    }
}

extension Queue: Sequence {
    func makeIterator() -> some IteratorProtocol {
        return QueueIterator(database: self)
    }
}

struct Queue<T>: CustomStringConvertible {
    var head: Node<T>?
    var tail: Node<T>?
    var count = 0

    var isEmpty: Bool {
        return head == nil
    }

    var description: String {
        guard let head = head else { return "Empty Queue" }
        return String(describing: head)
    }

    var peak: T? {
        return head?.value
    }
}

extension Queue {
    mutating private func push(_ value: T) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }

    mutating func enqueue(_ value: T) {
        count += 1
        if isEmpty {
            push(value)
            return
        }

        tail?.next = Node(value: value)
        tail = tail?.next
    }

    mutating func dequeue() {
        count -= 1
        head = head?.next

        if isEmpty {
            tail = nil
        }
    }
}
