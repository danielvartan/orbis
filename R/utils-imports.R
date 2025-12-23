# Borrowed from `rutils`: github.com/danielvartan/prettycheck
test_internet <- function() has_internet()

# Borrowed from `rutils`: github.com/danielvartan/prettycheck
check_internet <- function() {
  if (!test_internet()) {
    paste0(
      "No internet connection was found. ",
      "You must have an internet connection to run this function."
    )
  } else {
    TRUE
  }
}

# Borrowed from `rutils`: github.com/danielvartan/prettycheck
assert_internet <- function() {
  if (!test_internet()) {
    cli::cli_abort(check_internet())
  } else {
    invisible(TRUE)
  }
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
require_pkg <- function(...) {
  out <- list(...)

  lapply(
    out,
    checkmate::assert_string,
    pattern = "^[A-Za-z][A-Za-z0-9.]+[A-Za-z0-9]*$"
  )

  if (!identical(unique(unlist(out)), unlist(out))) {
    cli::cli_abort("'...' cannot have duplicated values.")
  }

  pkg <- unlist(out)
  namespace <- vapply(
    pkg,
    require_namespace,
    logical(1),
    quietly = TRUE,
    USE.NAMES = FALSE
  )
  pkg <- pkg[!namespace]

  if (length(pkg) == 0) {
    invisible(NULL)
  } else {
    cli::cli_abort(
      paste0(
        "This function requires the {.strong {pkg}} package{?s} ",
        "to run. You can install {?it/them} by running:",
        "\n\n",
        "install.packages(c(",
        "{paste(double_quote_(pkg), collapse = ', ')}",
        "))"
      )
    )
  }
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
double_quote_ <- function(x) paste0("\"", x, "\"")

# Borrowed from `rutils`: github.com/danielvartan/rutils
shush <- function(x, quiet = TRUE) {
  if (isTRUE(quiet)) {
    suppressMessages(suppressWarnings(x))
  } else {
    x
  }
}

# Borrowed from `groomr`: github.com/danielvartan/groomr
to_ascii <- function(x, from = "UTF-8") {
  checkmate::assert_character(x)
  checkmate::assert_string(from)

  x |> iconv(to = "ASCII//TRANSLIT")
}

# Borrowed from `groomr`: github.com/danielvartan/groomr
to_title_case_pt <- function(
  x, #nolint
  articles = TRUE,
  conjunctions = TRUE,
  oblique_pronouns = TRUE,
  prepositions = TRUE,
  custom_rules = c("(.)\\bD(el)\\b" = "\\1d\\2") # Del
) {
  checkmate::assert_character(x)
  checkmate::assert_flag(articles)
  checkmate::assert_flag(conjunctions)
  checkmate::assert_flag(oblique_pronouns)
  checkmate::assert_flag(prepositions)
  checkmate::assert_character(custom_rules, null.ok = TRUE)

  # Use `stringi::stri_escape_unicode` to escape unicode characters.
  # stringi::stri_escape_unicode("")

  # Use `tools::showNonASCIIfile` to show non-ASCII characters.
  # tools::showNonASCIIfile(here::here("R", "to_title_case_pt.R"))

  # Using `c("regex" = "replacement")` syntax
  rules <- c(custom_rules)

  if (isTRUE(articles)) {
    rules <- c(
      rules,
      # A | As
      "(.)\\bA(s)?\\b" = "\\1a\\2",
      # O | Os
      "(.)\\bO(s)?\\b" = "\\1o\\2",
      # Um | Uns | Uma | Umas
      "(.)\\bU((m(a(s)?)?)|ns)\\b" = "\\1u\\2"
    )
  }

  if (isTRUE(conjunctions)) {
    rules <- c(
      rules,
      # Conforme | Conquanto | Contudo
      "(.)\\bC(on(forme|quanto|tudo))\\b" = "\\1c\\2",
      # Durante
      "(.)\\bD(urante)\\b" = "\\1D\\2",
      # E | Embora | Enquanto | Então | Entretanto | Exceto
      "(.)\\bE((mbora|n(quanto|t(\u00e3o|retanto))|xceto)?)\\b" = "\\1e\\2",
      # Logo
      "(.)\\bL(ogo)\\b" = "\\1l\\2",
      # Mas
      "(.)\\bM(as)\\b" = "\\1m\\2",
      # Nem
      "(.)\\bN(em)\\b" = "\\1n\\2",
      # Ou | Ora
      "(.)\\bO(u|ra)\\b" = "\\1o\\2",
      # Pois | Porém | Porque | Porquanto | Portanto
      "(.)\\bP(o(is|r(\u00e9m|qu(e|anto)|tanto)))\\b" = "\\1p\\2",
      # Quando | Quanto | Que
      "(.)\\bQ(u(an[dt]o|e))\\b" = "\\1q\\2",
      # Se | Senão
      "(.)\\bS(e(n\u00e3o)?)\\b" = "\\1s\\2",
      # Todavia
      "(.)\\bT(odavia)\\b" = "\\1t\\2"
    )
  }

  if (isTRUE(oblique_pronouns)) {
    rules <- c(
      rules,
      # Lhe | Lhes
      "(.)\\bL(he(s)?)\\b" = "\\1l\\2",
      # Me | Meu | Meus | Mim | Minha | Minhas
      "(.)\\bM((e(u(s)?)?)|(i(m|(nha(s)?))))\\b" = "\\1m\\2",
      # Nos | Nosso | Nossa | Nossos | Nossas
      "(.)\\bN(os(s[ao](s)?)?)\\b" = "\\1n\\2",
      # Seu | Seus | Sua | Suas
      "(.)\\bS((e(u(s)?)?)|(ua(s)?))\\b" = "\\1s\\2",
      # Te | Teu | Teus | Ti | Tua | Tuas
      "(.)\\bT((e(u(s)?)?)|i|(ua(s)?))\\b" = "\\1t\\2",
      # Vos | Vosso | Vossa | Vossos | Vossas
      "(.)\\bV(os(s[ao](s)?)?)\\b" = "\\1v\\2"
    )
  }

  if (isTRUE(prepositions)) {
    rules <- c(
      rules,
      # Ao | Aos | Ante | Até | Após
      "(.)\\bA((o)(s)?|nte|t\u00e9|p\u00f3s)\\b" = "\\1a\\2",
      # As
      "(.)\\b\u00c0(s)?\\b" = "\\1\u00e0\\2",
      # Com | Contra
      "(.)\\bC(om|ontra)\\b" = "\\1c\\2",
      # Da | Das | Do | Dos | De | Desde
      "(.)\\bD(((a|o)(s)?)|(e(sde)?))\\b" = "\\1d\\2",
      # Em | Entre
      "(.)\\bE(m|ntre)\\b" = "\\1e\\2",
      # Na | Nas | No | Nos
      "(.)\\bN((a|o)(s)?)\\b" = "\\1n\\2",
      # Para | Perante | Pela | Pelas | Pelo | Pelos | Por
      "(.)\\bP(ara|(e((l(a|o)(s)?)|rante))|or)\\b" = "\\1p\\2",
      # Sem | Sob | Sobre
      "(.)\\bS(em|(ob(re)?))\\b" = "\\1s\\2",
      # Trás
      "(.)\\bT(r\u00e1s)\\b" = "\\1t\\2",
      # Del
      "(.)\\bD(el)\\b" = "\\1d\\2"
    )
  }

  out <-
    x |>
    stringr::str_to_title() |>
    stringr::str_replace_all(rules)

  # Deals with contractions like "Copo D'Agua" and "Sant'Ana do Livramento".
  out |>
    stringr::str_replace_all(
      "(\\b\\p{L}')\\p{Ll}|(\\p{Ll}')\\p{Ll}",
      function(m) paste0(substr(m, 1, 2), toupper(substr(m, 3, 3)))
    )
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
get_file_size <- function(file) {
  require_pkg("fs", "httr")

  checkmate::assert_character(file)

  url_pattern <- paste0(
    "(http[s]?|ftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|",
    "(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  )

  file <- stringr::str_trim(file)
  out <- character()

  for (i in seq_along(file)) {
    if (stringr::str_detect(file[i], url_pattern)) {
      out[i] <- get_file_size_by_url(file[i])
    } else {
      out[i] <- fs::file_size(file[i])
    }
  }

  out |> fs::fs_bytes()
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
get_file_size_by_url <- function(file) {
  require_pkg("fs", "httr")

  url_pattern <- paste0(
    "(http[s]?|ftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|",
    "(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  )

  assert_internet()
  checkmate::assert_character(file, pattern = url_pattern)

  out <- character()

  for (i in seq_along(file)) {
    request <- try(
      {
        file[i] |> httr::HEAD()
      },
      silent = TRUE
    )

    if (inherits(request, "try-error")) {
      out[i] <- NA
    } else if (!is.null(request$headers$`Content-Length`)) {
      out[i] <- as.numeric(request$headers$`content-length`)
    } else {
      out[i] <- NA
    }
  }

  out |> fs::fs_bytes()
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
count_na <- function(x) {
  checkmate::assert_atomic(x)

  length(which(is.na(x)))
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
download_file <- function(
  url,
  dir = ".",
  broken_links = FALSE
) {
  require_pkg("curl", "fs")

  url_pattern <- paste0(
    "(http[s]?|ftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|",
    "(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  )

  checkmate::assert_character(url, pattern = url_pattern, any.missing = FALSE)
  checkmate::assert_string(dir)
  checkmate::assert_directory_exists(dir, access = "w")

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  cli::cli_alert_info(
    paste0(
      "Downloading ",
      "{.strong {cli::col_red(length(url))}} ",
      "{cli::qty(length(url))}",
      "file{?s} to {.strong {dir}}"
    )
  )

  if (length(url) > 1) {
    cli::cat_line()
  }

  cli::cli_progress_bar(
    name = "Downloading files",
    total = length(url),
    clear = FALSE
  )

  broken_links <- character()

  for (i in url) {
    test <- try(
      i |>
        curl::curl_download(
          destfile = fs::path(dir, basename(i)),
          quiet = TRUE
        ),
      silent = TRUE
    )

    if (inherits(test, "try-error")) {
      cli::cli_alert_info(
        "The file {.strong {basename(i)}} could not be downloaded."
      )

      broken_links <- c(broken_links, i)
    }

    cli::cli_progress_update()
  }

  cli::cli_progress_done()

  if (isTRUE(broken_links)) {
    invisible(broken_links)
  } else {
    url |>
      magrittr::extract(!url %in% broken_links) %>%
      fs::path(dir, basename(.)) |>
      invisible()
  }
}

# Borrowed from `rutils`: github.com/danielvartan/rutils
long_string <- function(x) {
  checkmate::assert_string(x)

  x |>
    strwrap() |>
    paste0(collapse = " ") |>
    gsub(x = _, pattern = "\\s+", replacement = " ")
}
