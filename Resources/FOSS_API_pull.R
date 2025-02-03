exports_pull <- function(minyr, defl, name) {
    exports_get <- GET("https://apps-st.fisheries.noaa.gov/ods/foss/trade_data/", # nolint: indentation_linter.
        query = list(
            q = paste0('{
                "name":{', name, '},
                "source":"EXP",
                "year":{"$gt": ', minyr, "}}"),
            limit = 10000
        )
    )

    # check status of pull, will throw error if there's a problem
    # can use http_status(hake_get) to get info about error
    stop_for_status(exports_get, "pull exports. Use http_status(exports_get) to get more info")

    # extract all info from the json
    exports_list <- jsonlite::fromJSON(rawToChar(exports_get$content))

    # check that we're not running up against the row limit
    if (nrow(exports_list$items) == 10000) stop("Hit max row limit, increase the limit to something greater than 10000")
    if (nrow(exports_list$items) == 25) stop("Something went wrong with query, only returning 25 rows")

    exports_list$items$links <- NULL

    exports_list_items <- exports_list$items |>
        mutate(YEAR = as.numeric(year, .keep = 'unused')) |>
        left_join(defl, by = c('YEAR')) |>
        mutate(val = val/DEFL, .keep = 'unused')

    exports_bycountry <- mutate(exports_list_items,
        country = stringr::str_to_title(cntry_name)
    ) %>%
        group_by(year, country) %>%
        summarise(
            kilograms = sum(kilos),
            value = sum(val), .groups = "drop"
        ) %>%
        arrange(desc(value)) 

    return(list(
        exports = exports_list_items,
        exports_bycountry = exports_bycountry
    ))
}