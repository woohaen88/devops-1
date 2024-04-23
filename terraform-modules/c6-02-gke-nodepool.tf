resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes


  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
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
    service_account = "simplifywoopii@devops-421112.iam.gserviceaccount.com"
    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

}
