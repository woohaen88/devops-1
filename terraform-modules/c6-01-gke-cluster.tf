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

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    gcs_fuse_csi_driver_config {
      enabled = false
    }
  }

  datapath_provider = "ADVANCED_DATAPATH"
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block = "172.16.0.0/21"
    stack_type = "IPV4"
  }

  binary_authorization {
    evaluation_mode = "DISABLED"
  }

  default_max_pods_per_node = "110"
  private_cluster_config {
    enable_private_nodes = true
    master_global_access_config {
      enabled = true
    }
  }

  database_encryption {
    state = "DECRYPTED"
  }

  logging_config {
    enable_components = [ "SYSTEM_COMPONENTS", "WORKLOADS" ]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = true
    }
  }

  security_posture_config {
    mode = "BASIC"
    vulnerability_mode = "VULNERABILITY_DISABLED"
  }  
}

