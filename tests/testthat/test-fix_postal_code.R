testthat::test_that("fix_postal_code() | General test", {
  fix_postal_code("  01014908  ", squish = TRUE) |>
    testthat::expect_equal("01014908")

  fix_postal_code("01014908", min_char = 10) |>
    testthat::expect_equal(NA_character_)

  fix_postal_code("01014908", max_char = 5, trunc = FALSE) |>
    testthat::expect_equal(NA_character_)

  fix_postal_code("A1C14D08", remove_non_numeric = TRUE, pad = TRUE) |>
    testthat::expect_equal("11408000")

  fix_postal_code("12345678", remove_number_sequences = TRUE) |>
    testthat::expect_equal(NA_character_)

  fix_postal_code("01014908", max_char = 5, trunc = TRUE) |>
    testthat::expect_equal("01014")

  fix_postal_code("01253", max_char = 8, pad = TRUE) |>
    testthat::expect_equal("01253000")

  fix_postal_code(NA, max_char = 8, zero_na = TRUE) |>
    testthat::expect_equal("00000000")
})

testthat::test_that("fix_postal_code() | Error test", {
  # checkmate::assert_atomic(postal_code)
  fix_postal_code(
    postal_code = list(),
    min_char = 3,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_int(min_char, lower = 1)
  fix_postal_code(
    postal_code = "01014908",
    min_char = "a",
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  fix_postal_code(
    postal_code = "01014908",
    min_char = 0,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_int(max_char, lower = 1)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = "a",
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 0,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(squish)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 8,
    squish = "a",
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(remove_non_numeric)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = "a",
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(remove_number_sequences)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = "a",
    trunc = TRUE,
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(trunc)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = "a",
    pad = TRUE,
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(pad)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = "a",
    zero_na = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(zero_na)
  fix_postal_code(
    postal_code = "01014908",
    min_char = 3,
    max_char = 8,
    squish = TRUE,
    remove_non_numeric = TRUE,
    remove_number_sequences = TRUE,
    trunc = TRUE,
    pad = TRUE,
    zero_na = "a"
  ) |>
    testthat::expect_error()
})
