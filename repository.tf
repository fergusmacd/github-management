# the terraform resource for the repository
resource "github_repository" "github_management" {
  name        = "github-management"
  description = "Terraform based repository to manage all our GitHub repositories"

  private            = false
  has_issues         = true
  has_wiki           = false
  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
  auto_init          = false
  topics             = ["config", "terraform"]
}

# Set up baseline configs for the repo test
resource "github_branch_protection" "team_baseline_config" {
  repository     = github_repository.github_management.name
  branch         = "master"

  required_status_checks {
    # require up to date before merging
    strict = true
    contexts = ["atlas/mononoke/github-management", ]
  }
  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = false
  }
}
