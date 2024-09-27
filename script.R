library(igraph)
library(tidyverse)
library(progress)
db <- tools::CRAN_package_db()
db[!is.na(db$Deadline), c("Package", "Deadline")]

cran <- db |>
    janitor::clean_names() |>
    as_tibble() |>
    select(package, reverse_imports, reverse_suggests) |>
    dplyr::filter(!is.na(reverse_imports) | !is.na(reverse_suggests)) |>
    pivot_longer(reverse_imports:reverse_suggests, values_to = "reverse_depends") |>
    select(-name) |>
    mutate(reverse_depends = str_split(reverse_depends, ",")) |>
    unnest(reverse_depends) |>
    mutate(reverse_depends = str_trim(reverse_depends)) |>
    dplyr::filter(!is.na(reverse_depends)) |>
    graph_from_data_frame()

cran <- simplify(cran)
danger <- db$Package[!is.na(db$Deadline)]
danger <- danger[danger %in% V(cran)$name]
D <- distances(cran, v = match(danger, V(cran)$name), mode = "out")
sum(apply(D, 2, \(x) any(x <= 2))) / nrow(db)

archive_date <- db$Deadline[match(danger, db$Package)]
V(cran)$archive_date <- as.character("2100-01-01")
V(cran)$archive_date[match(danger, V(cran)$name)] <- archive_date
pb <- progress_bar$new(
    format = "  archiving [:bar] :percent eta: :eta",
    total = length(danger), clear = FALSE, width = 80
)
for (i in seq_along(danger)) {
    pb$tick()
    v <- match(danger[i], V(cran)$name)
    dday <- as.Date(V(cran)$archive_date[v])
    vbfs <- bfs(cran, v, "out", unreachable = FALSE, dist = TRUE)
    mdist <- max(vbfs$dist)
    for (d in seq_len(mdist)) {
        idx <- which(vbfs$dist == d)
        bye <- dday + days(14 * d)
        V(cran)$archive_date[idx] <- as.character(pmin(as.Date(V(cran)$archive_date[idx]), bye, na.rm = TRUE))
    }
}

sum(V(cran)$archive_date != "2100-01-01") / nrow(db)
max(as.Date(V(cran)$archive_date[V(cran)$archive_date != "2100-01-01"]))
