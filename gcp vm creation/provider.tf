terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.10.0"
    }
  }
}

provider "google" {
  project = "groovy-scarab-405905"
  region = "us-central1"
  zone = "us-central1-a"
  access_token = "ya29.a0AfB_byAOoW5IJjX9uh1TqcjNSlWqtKbyTFIhNsCMHe1fKg3B_FYjIC06VwofJBsAjdEMGl54A9ChuS0F-QCJ3opA666oLVud6ePSvwBCtxDdmUB4T5KLVypGa_FdBHsitc1mUic0MZhF9OjmdIZJJr2Qm0F1PcduNknGouxKQwaCgYKAbkSARESFQHGX2MiX_AstOFv_Vu0xF4sJad1oQ0177"
}