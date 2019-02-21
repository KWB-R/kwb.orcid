#' Helper function: known ORCIDs of KWB scientists
#' @return default ORCIDs of KWB scientists
#' @export  
#' @examples 
#' get_kwb_orcids()
#' 
get_kwb_orcids <- function() {
  
  c("Andreas Matzinger" = "0000-0001-5483-4594", 
    "Hauke Sonnenberg" = "0000-0001-9134-2871", 
    "Wolfgang Seis" = "0000-0002-7436-8575", 
    "Christoph Sprenger" = "0000-0002-0178-6645",
    "Michael Rustler" = "0000-0003-0647-7726"
  )
  
}

#' ORCID: get author metadata
#'
#' @param orcids character vector with valid ORCIDs (default: get_kwb_orcids())
#' @return data.frame with valid ORCID metadata for authors
#' @importFrom rorcid as.orcid
#' @importFrom data.table rbindlist
#' @export
#' @examples 
#' orcids <- get_kwb_orcids()
#' get_author_meta_for_orcids(orcids)
#' 
get_author_meta_for_orcids <- function(orcids = get_kwb_orcids()) {
  author_meta_list <- lapply(orcids, function(x) {
    author_meta <- rorcid::as.orcid(x)[[x]]


    author_url_list <- author_meta$`researcher-urls`$`researcher-url`

    has_url <- !is.null(names(author_url_list))

    if (has_url) {
      author_url <- paste(author_url_list$url.value, collapse = " , ")
    } else {
      author_url <- ""
    }

    data.frame(
      orcid = x,
      given_names = author_meta$name$`given-names`$value,
      family_name = author_meta$name$`family-name`$value,
      url = author_url,
      stringsAsFactors = FALSE
    )
  })

  author_meta_df <- data.table::rbindlist(author_meta_list)

  author_meta_df$orcid_link <- sprintf(
    "[%s](https://orcid.org/%s)",
    author_meta_df$orcid,
    author_meta_df$orcid
  )
  author_meta_df
}

#' Helper function: extract ORCID from path column (returned by rorcid::works())
#' @param path content of column "path" (returned by \code{\link[rorcid]{works}})
#' @return character vector with ORCIDS
extract_orcid_from_path <- function(path) {
  gsub(
    pattern = "/work/.*", replacement = "",
    gsub(pattern = "^/", replacement = "", path)
  )
}


#' ORCID: get all publications (using rorcid::works())
#' @param orcids character vector with valid ORCIDs (default: get_kwb_orcids())
#' @importFrom rorcid works
#' @importFrom data.table rbindlist
#' @importFrom dplyr left_join
#' @importFrom stats setNames
#' @return data.frame with all (public!) ORCID publications for provided ORCIDS
#' @export
#' @examples 
#' orcids <- get_kwb_orcids()
#' create_publications_df_for_orcids(orcids)
#' 
create_publications_df_for_orcids <- function(
orcids = get_kwb_orcids()) 
  {
  
  authors_meta <- get_author_meta_for_orcids(orcids)
  
  publications_list <- setNames(object = lapply(orcids, rorcid::works), 
                                authors_meta$family_name)

  publications_df <- data.table::rbindlist(publications_list, fill = TRUE)
  publications_df$orcid <- extract_orcid_from_path(publications_df$path)
  publications_df <- dplyr::left_join(
    x = authors_meta,
    y = publications_df,
    by = "orcid"
  )
  return(publications_df)
}
