od = function(edges, nodes = NULL) {
  
  if (!is.data.frame(edges)) stop("edges should be a data.frame or sf object")
  
  
  
  # if nodes are missing, try to extract them from edges
  if (missing(nodes)) {

    
    x = extract_nodes_from_edges(edges)
    
    
    
    
  }
  

}


extract_nodes_from_edges = function(edges) {
  if (any(c("o", "d") %in% names(edges))) stop("nodes not defined. Unable to add pointers to edges, since the column \"o\" and/or \"d\" have already been taken")
  
  if (inherits(edges, "sf")) {
    # option 1: geometry are linestrings 
    if (all(st_geometry_type(edges) %in% c("LINESTRING", "MULTILINESTRING"))) {
      eco = as.data.frame(st_coordinates(edges))
      ecolst = split(eco[,1:2], f = eco[[3]])
      
      co = rbind(do.call(rbind, lapply(ecolst, head, 1)),
                 do.call(rbind, lapply(ecolst, tail, 1)))
      
    } else {
      stop("nodes not defined. Unable to extract nodes from edges, since edges is an sf object with a different geometry than lines")
    }
  } else {
    ox = edges[,1]
    oy = edges[,2]
    dx = edges[,3]
    dy = edges[,4]
    if (!is.numeric(ox) || !is.numeric(oy) || !is.numeric(dx) || !is.numeric(dy)) {
      stop("nodes not defined. Unable to extract nodes from edges, since the first four columns are not origin x, origin y, destination x, and destination y")
    }
    co = data.frame(X = c(ox, dx), Y = c(oy, dy))
  }
  ids = od_id_max_min(co[,1], co[,2])
  
  # find unique nodes
  npid = which(!duplicated(ids))
  n = length(npid)
  
  # create nodes df
  uids = ids[!duplicated(ids)]
  ids2 = match(ids, uids)
  nodes = st_as_sf(co[npid, ], coords = c("X", "Y"), crs = st_crs(edges))
  nodes$id = 1L:n
  
  # attach node id to edges
  edges$o = ids2[1L:nrow(edges)]
  edges$d = ids2[(nrow(edges)+1L):(2*nrow(edges))]
  list(nodes = nodes, edges = edges)
}
  

# 
# 
# co1 = st_coordinates(rivers)
# co2 = st_coordinates(st_as_sf(st_sfc(c(st_multilinestring(list(matrix(1:6,3))), st_multilinestring(list(matrix(11:16,3)))))))
