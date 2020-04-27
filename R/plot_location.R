#' Plot Location
#'
#' Plot locations on interactive map
#'
#' @param x a `tibble` of formatted data which has been created using `formatExport``
#' @return a `leaflet` map object
#'
#' @export

plot_location <- function(x)
{
  PostCodeLookup <-
    purrr::map(x$PostCode, PostcodesioR::postcode_lookup) %>% dplyr::bind_rows() %>%
    dplyr::select(longitude, latitude)


  WARU_LookUp <-
    PostcodesioR::postcode_lookup('SY23 3FD') %>% dplyr::select(longitude, latitude)


  map_ob <- leaflet::leaflet() %>% leaflet::addTiles() %>%
    leaflet::addCircleMarkers(
      PostCodeLookup$longitude,
      PostCodeLookup$latitude,
      radius = 1.5,
      weight = 3
    ) %>%
    leaflet::addMarkers(WARU_LookUp$longitude, WARU_LookUp$latitude) %>%
    leaflet::addCircles(
      WARU_LookUp$longitude,
      WARU_LookUp$latitude,
      radius = c(10000, 20000, 30000),
      color = 'red',
      weight = 2,
      fillColor = 'transparent'
    )

  return(map_ob)



}
