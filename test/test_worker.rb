require "test_helpers"

class TestWorker < RSpecQTest
  def test_files_to_example_ids
    worker = new_worker("files_to_examples")

    expected = [
      "./test/sample_suites/files_to_examples/spec/foo_spec.rb[1:1]",
      "./test/sample_suites/files_to_examples/spec/foo_spec.rb[1:2:1]",
      "./test/sample_suites/files_to_examples/spec/foo_spec.rb[1:2:2]",
      "./test/sample_suites/files_to_examples/spec/bar_spec.rb[1:1]",
    ]

    actual = worker.files_to_example_ids(
      [
        "./test/sample_suites/files_to_examples/spec/foo_spec.rb",
        "./test/sample_suites/files_to_examples/spec/bar_spec.rb",
      ]
    )

    assert_equal expected.sort, actual.sort
  end

  def test_files_to_example_ids_failure_fallback
    worker = new_worker("files_to_examples_fallback")

    expected = [
      "./test/sample_suites/files_to_examples_fallback/spec/foo_spec.rb",
      "./test/sample_suites/files_to_examples_fallback/spec/bar_spec.rb"
    ]

    actual = worker.files_to_example_ids(
      [
        "./test/sample_suites/files_to_examples_fallback/spec/foo_spec.rb",
        "./test/sample_suites/files_to_examples_fallback/spec/bar_spec.rb",
      ]
    )

    assert_equal expected.sort, actual.sort
  end
end
