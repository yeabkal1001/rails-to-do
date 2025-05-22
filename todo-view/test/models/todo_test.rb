require "test_helper"

class TodoTest < ActiveSupport::TestCase
  test "should not save todo without title" do
    todo = Todo.new
    assert_not todo.save, "Saved the todo without a title"
  end

  test "should not save todo with short title" do
    todo = Todo.new(title: "Hi")
    assert_not todo.save, "Saved the todo with a short title"
  end

  test "should save todo with valid title" do
    todo = Todo.new(title: "Valid Title")
    assert todo.save, "Couldn't save the todo with a valid title"
  end
end
