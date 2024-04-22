# "remove_default_node_pool"
# Cluster는 default node pool 없이 생성이 불가능함
# 그래서 remove_default_node_pool 값을 "true"로 설정하면 default node pool을 작게 생성한 뒤 바로 삭제
resource "google_container_cluster" "primary" {
  name                     = "${local.name}-gke"
  location                 = var.region
  min_master_version       = "1.29"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet.name
  deletion_protection      = false
  node_locations = [
    "asia-northeast3-a",
    "asia-northeast3-b",
    "asia-northeast3-c"
  ]
  release_channel {
    channel = "RAPID"
  }

  datapath_provider = "ADVANCED_DATAPATH"
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

