#' Hash Code
#'
#' Create a simple hash code for sanity checking of database
#'
#' @param x a `tibble` of formatted data
#' @return a numeric vector of distance in km
#'
#' @keywords internal

hash_code <- function(x)
{

  x_select <- x %>% dplyr::select(Surname, DOB, EmailAddress)

  x_paste <-
    stringr::str_c(x_select$Surname,
                   '_',
                   x_select$DOB,
                   '_',
                   x_select$EmailAddress)

  x_paste <- gsub(' ', '', x_paste)


  sha256_hash <- openssl::sha256(x_paste)

  return(sha256_hash)

}
