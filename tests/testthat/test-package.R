context('test-package')


test_that('format-export', {
  example_file <-
    system.file('example_export.csv', package = 'participantInterest')

  example_data <-
    readr::read_csv(example_file, col_types = readr::cols())

  format_data <- formatExport(example_data)

  expect_true(nrow(format_data) == nrow(example_data))
  expect_true(ncol(format_data) == ncol(example_data))

})
