#' Create Lookup Authors KWB
#'
#' @param orcids character vector with valid ORCIDs (default: get_kwb_orcids())
#' @return data frame with authors information (as required for R packages) 
#' @export
#' @importFrom dplyr rename mutate select
#' @importFrom magrittr %>%
#' @examples 
#' orcids <- get_kwb_orcids()
#' create_lookup_authors_kwb(orcids)
#' 
create_lookup_authors_kwb <- function(orcids = get_kwb_orcids()) {
  
  kwb.orcid::get_author_meta_for_orcids(orcids) %>%
  dplyr::rename("given" = .data$given_names,
                "family" = .data$family_name,
                "comment" = .data$orcid) %>%
  dplyr::mutate(mail = sprintf("%s.%s@kompetenz-wasser.de",
                               tolower(.data$given),
                               tolower(.data$family))) %>%
  dplyr::select(.data$given, .data$family, .data$mail, .data$comment)
  
}