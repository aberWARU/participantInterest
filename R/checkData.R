#' Check Data
#'
#' Flag up any potential erorrs
#'
#' @param x a `tibble` of formatted data that has been created using `formatExport`
#' @return a `tibble`
#'
#' @export

checkData <- function(x)
{
  # check for DOB erors (< 18 | > 100)

  age <-
    lubridate::as.period(lubridate::interval(x$DOB, Sys.Date()),
                         unit = "year")

  age_yr <- age$year

  dob_error_idx <- which(age_yr < 18 | age_yr > 100)

  # check for distance errors (> 50km from WARU)

  distance_error_idx <- which(x$RelativeDistance > 50)


  # check that email address seems valid

  validateEmail <- function(x)
  {
    return(
      grepl(
        "\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>",
        as.character(x),
        ignore.case = TRUE
      )
    )
  }


  email_error <- purrr::map_lgl(x$EmailAddress, validateEmail)

  email_error_idx <- which(idx == FALSE)

  x <-
    x %>% tibble::add_column(DOB_ERROR = 0,
                             .after = 'HASH') %>% tibble::add_column(DIST_ERROR = 0,
                                                                     .after = 'HASH') %>% tibble::add_column(EMAIL_ERROR = 0,
                                                                                                             .after = 'HASH')

  if (length(dob_error_idx) > 0) {
    x$DOB_ERROR[dob_error_idx] <- 1
  }

  if (length(distance_error_idx) > 0) {
    x$DIST_ERROR[distance_error_idx] <- 1
  }

  if (length(email_error_idx) > 0) {
    x$EMAIL_ERROR[email_error_idx] <- 1
  }

  return(x)
}
