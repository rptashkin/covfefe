#' Use \code{\link{covfefe_color_palette}} to construct palettes of desired length.
#' @name covfefe_palette
#' @docType data
NULL
#' Covfefe coachella palette generator
#'
#' @param n Number of colours desired. Unfortunately most palettes now only
#'   have 4 or 5 colours. But hopefully we'll add more palettes soon. 
#'   If omitted, uses all colours.
#' @param number ID of desired palette (1 to 3)
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#' @return A vector of colours.
#' @export
#' @keywords colours
#' @examples
#' covfefe_color_palette(2, 8)
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- covfefe_palette(1, number = 2, type = "continuous")
#' image(volcano, col = pal)
#' 
covfefe_palette  <- function(name, n, type = c("discrete", "continuous")) {
    type <- match.arg(type)
    data("covfefe_palettes")
    pal <- covfefe_palettes[[name]]
    if (is.null(pal))
        stop("Palette not found.")
    
    if (missing(n)) {
        n <- length(pal)
    }
    
    if (type == "discrete" && n > length(pal)) {
        stop("Number of requested colors greater than what palette can offer")
    }
    
    out <- switch(type,
                  continuous = grDevices::colorRampPalette(pal)(n),
                  discrete = pal[1:n]
    )
    structure(out, class = "palette", name = name)
}

#' @export
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
    ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "number"), cex = 1, family = "serif")
}

