variable "auto" {
  description                         = "(Optional) The Secret will automatically be replicated without any restrictions."
  type                                = list(object(
    {
      customer_managed_encryption     = list(object(
        {
          kms_key_name                = string
        }
      ))
    }
  ))
  
  default                             = [ 
    {
      customer_managed_encryption     = [
        /* {
          kms_key_name                = null
        } */
      ]
    }
  ]
} 

/* variable "user_managed" {
  description                         = " (Optional) The Secret will be replicated to the regions specified by the user."
  type                                = list(object(
    {
      replicas                        = list(object(
        {
          location                    = string
          customer_managed_encryption = list(object(
            {
              kms_key_name            = string
            }
          ))
        }
      ))
    }
  ))
  
  default                             = [ 
    {
      replicas                        = [ 
        {
          location                    = "us-east5"
          customer_managed_encryption = [
            {
              kms_key_name            = "kms-key"
            }
          ]
        }
      ]
    } 
  ]
} */ 

variable "secret_id" {
  description                         = "(Required) This must be unique within the project.."
  type                                = string
  sensitive                           = false
}

variable "labels" {
  description                         = "(Optional) The labels assigned to this Secret. Label keys must be between 1 and 63 characters long, have a UTF-8 encoding of maximum 128 bytes."
  type                                = map(string) 
}

variable "annotations" {
  description                         = "Custom metadata about the secret. Annotations are distinct from various forms of labels. Annotations exist to allow client tools to store their own state information without requiring a database."
  type                                = map(string)
}

variable "version_aliases" {
  description                         = "(Optional) Mapping from version alias to version name."
  type                                = map(string)
}

variable "topics" {
  description                         = "(Optional) A list of up to 10 Pub/Sub topics to which messages are published when control plane operations are called on the secret or its versions."
  type                                = list(object(
    {
      name                            = string
    }
  ))
}

variable "expire_time" {
  description                         = "(Optional) Timestamp in UTC when the Secret is scheduled to expire."
  type                                = string
}

variable "ttl" {
  description                         = "(Optional) Custom metadata about the secret. Annotations are distinct from various forms of labels. Annotations exist to allow client tools to store their own state information without requiring a database."
  type                                = string
}

variable "rotation" {
  description                         = "(Optional) The rotation time and period for a Secret."
  type                                = list(object(
    {
      next_rotation_time              = string
      rotation_period                 = string
    }
  ))
}
  
variable "project_id" {
  description                         = "(Optional) The ID of the project in which the resource belongs"
  type                                = string
}

variable "secret_data" {
    description                       = " (Required) Secret Manager secret resource"
    type                              = string
    default                           = "()"
}

variable "enabled" {
    description                       = "(Optional) The current state of the SecretVersion.."
    type                              = bool 
}

variable "deletion_policy" {
    description                       = "(Optional) The deletion policy for the secret version. Setting ABANDON allows the resource to be abandoned rather than deleted. Setting DISABLE allows the resource to be disabled rather than deleted. Default is DELETE.."
    type                              = string 
}

variable "is_secret_data_base64" {
    description                       = "(Optional) If set to 'true', the secret data is expected to be base64-encoded string and would be sent as is."
    type                              = bool
}