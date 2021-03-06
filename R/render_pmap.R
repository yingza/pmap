#' @title Render the process map
#' @description Basically, this function just called `DiagrammeR::render_graph()`
#' @usage render_pmap(p, title = NULL)
#' @param p the process map object created by `create_pmap_graph()` function
#' @param title The title of rendered graph
#' @examples
#' library(dplyr)
#' p <- generate_eventlog() %>% create_pmap(target_types = c("target"))
#' render_pmap
#' @seealso [create_pmap]
#' @importFrom DiagrammeR   render_graph
#' @export
render_pmap <- function(p, title = NULL) {
  DiagrammeR::render_graph(p, title = title)
}
