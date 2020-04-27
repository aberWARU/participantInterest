#' Plot Gender
#'
#' Produce a simple bar plot of the number of records by Gender
#'
#' @param x a `tibble` of formatted data which has been created using `formatExport``
#' @return a `ggplot` object
#'
#' @export

plot_gender <- function(x)
{
  gender_sum <- x %>% dplyr::group_by(GENDER) %>% dplyr::count()

  p1 <-
    ggplot(gender_sum, aes(fill = GENDER, y = n, x = GENDER)) +
    geom_bar(position = "stack", stat = "identity") +
    theme_bw(base_size = 12) +
    labs(x = '', '# of Entries', title = 'Number of entries by gender') +
    scale_fill_manual(values = c("#FAAB18", "#1380A1", "#990000")) + guides(fill = 'none') +
    theme(
      axis.text.x = element_text(face = 'bold', size = 11),
      axis.text.y = element_text(face = 'bold', size = 11)
    )

  return(p1)
}
