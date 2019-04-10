class Stack
  def initialize
    @store = Array.new
  end

  def pop
    @store.pop
  end

  def push(element)
    @store.push(element)
    self
  end

  def size
    @store.size
  end

  def top
    size - 1
  end

  def last
    @store.last
  end
end
