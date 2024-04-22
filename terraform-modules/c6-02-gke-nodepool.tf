resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes


  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]
    labels       = local.common_tags
    machine_type = var.gke_machine_type
    disk_size_gb = 20
    tags         = ["gke-node", "${local.name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    spot       = true
    image_type = "COS_CONTAINERD"
    disk_type  = "pd-balanced"
  }

}
