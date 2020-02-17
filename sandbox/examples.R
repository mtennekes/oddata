# example 1
edges = readRDS("~/pCloudDrive/flows_commutingNL/data/throughput/gm_od_with_diag.rds")
nodes = readRDS("~/pCloudDrive/flows_commutingNL/data/throughput/gm_centroids.rds")

# example 2
edges = stplanr::flow
nodes = stplanr::cents_sf

# example 3
edges = stplanr::od_data_sample
nodes = stplanr::cents_sf

# example 4
edges = stplanr::flow_dests
nodes_orig = stplanr::cents_sf
nodes_dest = stplanr::destinations_sf

