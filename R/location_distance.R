#' Convert PostCode to distance
#'
#' Convert PostCodes to the distance (km) from Wellbeing-and-health Assessment Research Unit (WARU)
#'
#' @param x a `tibble` of formatted data
#' @return a numeric vector of distance in km
#'
#' @keywords internal

location_distance <- function(x)
{
  PostCodeLookup <-
    purrr::map(x$PostCode, PostcodesioR::postcode_lookup) %>% dplyr::bind_rows() %>%
    dplyr::select(longitude, latitude)


  WARU_LookUp <-
    PostcodesioR::postcode_lookup('SY23 3FD') %>% dplyr::select(longitude, latitude)

  DistanceFromWARU <-
    purrr::map2_dbl(PostCodeLookup$latitude, PostCodeLookup$longitude, ~ {
      geosphere::distm(c(.x, .y),
                       c(WARU_LookUp$latitude, WARU_LookUp$longitude),
                       fun = geosphere::distHaversine)
    })

  DistanceFromWARU_KM <- round(DistanceFromWARU / 1000, digits = 1)

  return(DistanceFromWARU_KM)

}
