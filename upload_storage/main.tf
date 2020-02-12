provider "google" {
  project     = "staging-265722"
  region      = "asia-southeast1"
}

resource "google_storage_bucket_object" "sample_file" {
  name   = "sample_file"
  source = "sample_file.txt"
  bucket = "dpoinbox_bucket"
}