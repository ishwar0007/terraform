provider "github" {
  token="Github-Access-Token"
}

resource "github_repository" "terraform-first-repo" {
  name = "first-terraform-repo"
  description = "First Repo"
  visibility = "private"
}

resource "github_repository" "terraform-second-repo" {
  name = "second-terraform-repo"
  description = "second Repo"
  visibility = "public"
}

output "terraform-first-repo" {
  value = github_repository.terraform-first-repo.ssh_clone_url
}
