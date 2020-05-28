require 'pry'

# Design my own linked list data structure in Ruby
class LinkedList
    attr_accessor :head, :tail

    def initialize 
        @head = nil 
        @tail = nil 
    end 

    def empty?
        self.head == nil 
    end 

    # Append method adds a node to the end of the list
    # Takes in a value, not a Node object 
    def append(value)
        #First check if Linked List is empty
        if self.empty? 
            self.head = Node.new(value)
            self.tail = self.head 
        else 
            new_node = Node.new(value)
            self.tail.next = new_node 
            self.tail = new_node
        end 
    end
    
    # Helper method finds first node with value 
    # equal to the parameter value. Also takes in 
    # the current node instance to be comparing  
    # We will assume value is in the linked list for simplicity
    def find_node(value, node)
        if node.value == value 
            node 
        else 
            find_node(value, node.next)
        end 
    end 

    # Append_after adds a node with provided value 
    # at position directly after node with the 
    # provided target value 
    def append_after(value, target)
        target_node = find_node(target, self.head)
        temp_reference = target_node.next 
        target_node.next = Node.new(value)
        target_node.next.next = temp_reference
    end

    def find_node_before(value, node) 
        if node.next.value == value 
            return [node, node.next]
        else
            find_node_before(value, node.next)
        end 
    end

    # Again, for simplicity, we will assume value is in the Linked List. We will write find_node_before as a helper 
    def delete(value)
        # Case in which you want to delete first element
        if self.head.value == value 
            self.head = self.head.next
        else
            node_before, node_to_delete = find_node_before(value, self.head)
            temp_node = node_to_delete.next 
            node_before.next = temp_node
        end 
    end 

    def to_s
        str = "["
        temp_node = self.head 
        while !temp_node.nil?
            str += temp_node.to_s
            temp_node = temp_node.next
        end
        str + "]"
    end
end 


# The Node class 
class Node 
    # Value of a node cannot change, but the ordering of the nodes can change
    attr_reader :value
    attr_accessor :next 

    def initialize(value)
        @value = value 
        @next = nil
    end 

    def to_s
        "#{self.value}," #if you have time, add logic so tail doesn't print comma
    end 
end 

list = LinkedList.new
list.append(5)
list.append(10)
list.append(15)
puts "The list is: #{list}"
list.append_after(25, 10)
puts "The list is: #{list}"