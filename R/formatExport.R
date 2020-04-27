#' Format Recruitment Export
#'
#' The recruitment database is populated using a Jisc survey which is e-mailed out to potential contacts. This function
#' formats the direct export from Jisc ready for validation and upload using `waruDB`
#'
#' @param x a `tibble` of the raw Jisc output using `readr::read_csv`
#' @return a `tibble`
#' @export

formatExport <- function(x)
{
  RENAME <- c(
    'DATE',
    'TITLE',
    'Forename',
    'Surname',
    'DOB',
    'ContactNumber',
    'EmailAddress',
    'PostCode',
    'ContactMethod',
    'Smoker',
    'Allergens',
    'WhichAllergens',
    'DietReq',
    'BloodSample',
    'BloodSampleComment',
    'UrineSample',
    'UrineSampleComment',
    'CompletionDate'
  )

  names(x) <- RENAME

  x$DATE <- lubridate::dmy(x$DATE)
  x$DOB <- lubridate::dmy(x$DOB)

  x$Smoker[x$Smoker == 'No'] <- FALSE
  x$Smoker[x$Smoker == 'Yes'] <- TRUE

  x$Allergens[x$Allergens == 'No'] <- FALSE
  x$Allergens[x$Allergens == 'Yes'] <- TRUE

  x$UrineSample[x$UrineSample == 'No'] <- FALSE
  x$UrineSample[x$UrineSample == 'Yes'] <- TRUE

  x$BloodSample[x$BloodSample == 'No'] <- FALSE
  x$BloodSample[x$BloodSample == 'Yes'] <- TRUE

  x$PostCode <- toupper(x$PostCode)
  x$PostCode <- gsub(' ', '', x$PostCode)

  x$ContactNumber <- gsub(' ', '', x$ContactNumber)

  x$TITLE <- toupper(x$TITLE)
  x$TITLE <- gsub('/', '', x$TITLE)
  x$TITLE <- gsub('\\.', '', x$TITLE)


  x <- x %>% tibble::add_column(., GENDER = NA, .after = 'TITLE')

  female_dict <- c('MISS', 'MRS', 'MS')
  male_dict <- c('MR')

  female_id <- which(x$TITLE %in% female_dict)
  male_id <- which(x$TITLE %in% male_dict)
  unknown_id <- which(!x$TITLE %in% c(female_dict, male_dict))


  x$GENDER[female_id] <- 'FEMALE'
  x$GENDER[male_id] <- 'MALE'
  x$GENDER[unknown_id] <- 'UNKNOWN'

  relative_distance <- location_distance(x)

  x <- x %>% dplyr::mutate(RelativeDistance = relative_distance)

  xhash <- hash_code(x)

  x <- x %>% dplyr::mutate(HASH = xhash)

  return(x)

}
