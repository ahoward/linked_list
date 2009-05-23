class LinkedList
  Node = Struct.new :object, :prev, :next

  include Enumerable

  def LinkedList.[](*args)
    new(*args)
  end

  attr :size

  def initialize(*args)
    replace(args)
  end

  def replace(args=nil)
    @first = Node.new
    @last = Node.new
    @first.next = @last
    @last.prev = @first
    @size = 0
    args = args.to_a
    args.to_a.each{|arg| push(arg)} unless args.empty?
    self
  end

  def first
    not_empty! and @first.next.object
  end

  def first_node
    not_empty! and @first.next
  end

  def last
    not_empty! and @last.prev.object
  end

  def last_node
    not_empty! and @last.prev
  end

  def not_empty!
    @size <= 0 ? raise('empty') : @size
  end

  def push(object)
    push_node(Node.new(object, @last.prev, @last)).object
  end

  def push_node(node)
    @last.prev.next = node
    @last.prev = node
    @size += 1
    node
  end

  def <<(object)
    push(object)
    self
  end

  def pop
    pop_node.object
  end

  def pop_node
    raise('empty') if @size <= 0
    node = @last.prev
    node.prev.next = @last
    @last.prev = node.prev
    @size -= 1
    node
  end

  def unshift(object)
    unshift_node(Node.new(object, @first, @first.next)).object
  end

  def unshift_node(node)
    @first.next.prev = node
    @first.next = node
    @size += 1
    node
  end

  def shift
    shift_node.object
  end

  def shift_node
    raise('empty') if @size <= 0
    node = @first.next
    node.next.prev = @first
    @first.next = node.next
    @size -= 1
    node
  end

  def remove_node(node)
    not_empty!
    node.prev.next = node.next
    node.next.prev = node.prev
    node
  end

  def each_node
    node = @first.next
    while node != @last
      yield node
      node = node.next
    end
    self
  end

  def each
    each_node{|node| yield node.object}
  end

  def reverse_each_node
    node = @last
    loop do
      yield node
      node = node.prev
      if ! node
        break
      end
    end
    self
  end

  def reverse_each
    reverse_each_node{|node| yield node.object}
  end

  alias_method '__inspect__', 'inspect' unless instance_methods.include?('__inspect__')

  def inspect
    to_a.inspect
  end
end
