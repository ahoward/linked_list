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
    node = Node.new(object, @last.prev, @last)
    @last.prev.next = node
    @last.prev = node
    @size += 1
    object
  end

  def <<(object)
    push(object)
    self
  end

  def pop
    raise('empty') if @size <= 0
    node = @last.prev
    node.prev.next = @last
    @last.prev = node.prev
    @size -= 1
    node.object
  end

  def unshift(object)
    node = Node.new(object, @first, @first.next)
    @first.next.prev = node
    @first.next = node
    @size += 1
    object
  end

  def shift
    raise('empty') if @size <= 0
    node = @first.next
    node.next.prev = @first
    @first.next = node.next
    @size -= 1
    node.object
  end

  def remove(node)
    not_empty!
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def each
    node = @first.next
    while node != @last
      yield node.object
      node = node.next
    end
    self
  end

  def reverse_each
    node = @last
    loop do
      yield node.object
      node = node.prev
      if ! node
        break
      end
    end
    self
  end

  alias_method '__inspect__', 'inspect' unless instance_methods.include('__inspect__')

  def inspect
    to_a.inspect
  end
end
