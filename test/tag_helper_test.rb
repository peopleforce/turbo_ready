# frozen_string_literal: true

require "test_helper"

class TurboReady::TagHelperTest < ActiveSupport::TestCase
  include TurboReady::TagHelper

  test "with string method" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"example\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("example", id: 1)
    assert_equal expected, actual
  end

  test "with symbol method" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"example\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:example, id: 1)
    assert_equal expected, actual
  end

  test "with camel_case method" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"exampleMethod\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:example_method, id: 1)
    assert_equal expected, actual
  end

  test "with camel_case method camelize: false" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"example_method\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:example_method, id: 1, camelize: false)
    assert_equal expected, actual
  end

  test "with basic args" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"example\",\"args\":[42,\"value\",true]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:example, args: [42, "value", true], id: 1)
    assert_equal expected, actual
  end

  test "with basic args for console log" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"receiver\":\"console\",\"method\":\"log\",\"args\":[\"Hello World!\"]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("console.log", args: ["Hello World!"], id: 1)
    assert_equal expected, actual
  end

  test "with array args" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"exampleMethod\",\"args\":[\"a\",\"b\",\"c\",{\"camelizeYes\":true}]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:example_method, args: [:a, :b, :c, {camelize_yes: true}], id: 1)
    assert_equal expected, actual
  end

  test "with array args camelize: false" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"example_method\",\"args\":[\"a\",\"b\",\"c\",{\"camelize_no\":true}]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:example_method, args: [:a, :b, :c, {camelize_no: true}], camelize: false, id: 1)
    assert_equal expected, actual
  end

  test "with id selector" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"selector\":\"#example-id\",\"method\":\"example\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("example", selector: "#example-id", id: 1)
    assert_equal expected, actual
  end

  test "with class selector" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"selector\":\".example-class\",\"method\":\"example\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("example", selector: ".example-class", id: 1)
    assert_equal expected, actual
  end

  test "with complex selector" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"selector\":\".example-class[attr='value']\",\"method\":\"example\"}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("example", selector: ".example-class[attr='value']", id: 1)
    assert_equal expected, actual
  end

  test "with string event" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"dispatchEvent\",\"args\":[\"turbo-ready:test\"]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("dispatchEvent", args: ["turbo-ready:test"], id: 1)
    assert_equal expected, actual
  end

  test "with symbol event" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"method\":\"dispatchEvent\",\"args\":[\"turbo-ready:test\"]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:dispatch_event, args: ["turbo-ready:test"], id: 1)
    assert_equal expected, actual
  end

  test "with event args and selector" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"selector\":\"button.turbo-ready\",\"method\":\"dispatchEvent\",\"args\":[\"turbo-ready:test\",{\"bubbles\":true,\"detail\":{\"test\":true}}]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:dispatch_event,
      args: ["turbo-ready:test", {bubbles: true, detail: {test: true}}],
      selector: "button.turbo-ready",
      id: 1)
    assert_equal expected, actual
  end

  test "with event and camelized args" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"selector\":\"button.turbo-ready\",\"method\":\"dispatchEvent\",\"args\":[\"turbo-ready:test\",{\"detail\":{\"convertsToCamelCase\":true}}]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag(:dispatch_event,
      args: ["turbo-ready:test", {detail: {converts_to_camel_case: true}}],
      selector: "button.turbo-ready",
      id: 1)
    assert_equal expected, actual
  end

  test "with event and opt-out of camelized args" do
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"selector\":\"button.turbo-ready\",\"method\":\"dispatchEvent\",\"args\":[\"turbo-ready:test\",{\"detail\":{\"converts_to_camel_case\":false}}]}</template></turbo-stream>"
    actual = turbo_stream_invoke_tag("dispatchEvent",
      args: ["turbo-ready:test", {detail: {converts_to_camel_case: false}}],
      selector: "button.turbo-ready",
      camelize: false,
      id: 1)
    assert_equal expected, actual
  end
end
