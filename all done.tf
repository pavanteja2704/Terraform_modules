resource "google_data_loss_prevention_job_trigger" "basic" {
  parent = "projects/my-project-name"
  description = var.description
  display_name = var.display_name
  trigger_id = var.trigger
  status =var.status
    triggers {
     manual = var.manual
     dynamic "schedule" {
       for_each = lookup(trigger.value,"schedule",[])
       content {
          recurrence_period_duration = lookup(schedule.value,"recurrence_period_duration",null)
        }
      }
    }
    dynamic"inspect_job" {
      for_each = var.inspect_job[*]
      content {
        inspect_template_name = var.inspect_template_name
        dynamic "inspect_config" {
          for_each = var.inspect_config[*]
          content {
            exclude_info_types = lookup(inspect_config.value,"exclude_info_types",null)
            include_quote      = lookup(inspect_config.value,"include_quote",null)
            min_likelihood     = lookup(inspect_config.value,"min_likelihood",null)
            dynamic"limits" {
              for_each = lookup(inspect_config.value,"limits",[])
              content{ 
                max_findings_per_item    = lookup(limits.value,"max_findings_per_item",null)
                max_findings_per_request = lookup(limits.value,"max_findings_per_request",null)
                dynamic "max_findings_per_info_type"{
                  for_each = var.max_findings_per_info_type[*]
                  content {
                    max_findings        =lookup(max_findings_per_info_type.value,"max_findings",null)
                    dynamic "info_type"{
                     for_each = lookup(max_findings_per_info_type.value,"info_type",[])
                     content {
                       name    = lookup(info_type.value,"name",null)
                       version = lookup(info_type.value,"version",null)
                      }
                    }
                    dynamic "sensitivity_score"{
                      for_each = lookup(max_findings_per_info_type.value,"sensitivity_score",[])
                      content{
                        score = lookup(sensitivity_score.value,"score",null)
                      } 
                    }
                  }
                }
              }
            }
            dynamic"info_types" {
              for_each   = lookup(inspect_config.value,"info_types",[])
              content {
                name     = lookup(info_type.value,"name",null)
                version  = lookup(info_type.value,"version",null)
                dynamic "sensitivity_score" {
                  for_each = lookup(info_types.value,"sensitivity_score",[])
                  content{
                    score = lookup(sensitivity_score.value,"score",null)
                  }
                }
              }
            }
            dynamic"rule_set" {
              for_each   = lookup(inspect_config.value,"rule_set",[])
              content {
                dynamic"info_types" {
                 for_each = lookup(rule_set.value,"info_types",[])
                 content {
                   name     = lookup(info_type.value,"name",null)
                   version  = lookup(info_type.value,"version",null)
                   dynamic "sensitivity_score" {
                     for_each = lookup(info_types.value,"sensitivity_score",[])
                     content{
                       score = lookup(sensitivity_score.value,"score",null)
                      }
                    }
                  }
                }
                dynamic"rules"{
                for_each = lookup(rule_set.value,"rules",[])
                content{
                  dynamic "hotword_rule"{
                     for_each = lookup(rules.value,"hotword_rule",[])
                      content {
                        dynamic "hotword_regex" {
                         for_each = lookup(rules.value,"hotword_regex",[])
                          content {
                            pattern = lookup(hotword_regex.value,"pattern",null)
                            group_indexes =lookup(hotword_regex.value,"group_indexes",null)
                          } 
                        }  
                        dynamic"proximity"{
                          for_each = lookup(rules.value,"proximity",[])
                          content{
                            window_before= lookup(proximity.value,"window_before",null)
                            window_after = lookup(proximity.value,"window_after",null)
                          }
                        }
                        dynamic"likelihood_adjustment"{
                         for_each = lookup(rules.value,"likelihood_adjustment",[])
                         content{
                           fixed_likelihood    =  lookup(likelihood_adjustment.value,"fixed_likelihood",null)
                           relative_likelihood = lookup(likelihood_adjustment.value,"relative_likelihood",null)
                          }
                        }
                      }
                   }
                  dynamic "exclusion_rule" {
                    for_each = lookup(rules.value,"hotword_rule",[])
                    content {
                     matching_type= lookup(exclusion_rule.value," matching_type",null)
                     dynamic"dictionary"{
                       for_each = lookup(exclusion_rule.value,"dictionary",[])
                        content {
                         dynamic"word_list"{
                           for_each = lookup(dictionary.value,"word_list",[])
                           content {
                             words = lookup(word_list.value,"  words",null)
                            }
                         }
                          dynamic"cloud_storage_path"{
                          for_each = lookup(dictionary.value,"cloud_storage_path",[])
                          content {
                            path=  lookup(cloud_storage_path.value,"path",null)
                          }
                         }
                        }
                      }
                     dynamic"regex"{
                       for_each = lookup(exclusion_rule.value,"regex",[])
                       content{
                         pattern = lookup(regex.value,"pattern",null) 
                         group_indexes= lookup(regex.value,"group_indexes",null)
                        }
                      }
                     dynamic"exclude_info_types"{
                       for_each = lookup(exclusion_rule.value,"exclude_info_types",[])
                       content{
                         dynamic "info_types"{
                          for_each = lookup(exclude_info_types.value,"info_types",[])
                          content{
                            name   = lookup(info_types.value,"name",null)
                            version = lookup(info_types.value,"version",null)
                            dynamic"sensitivity_score"{
                             for_each = lookup(exclude_info_types.value,"sensitivity_score",[])
                              content{
                               score =lookup(sensitivity_score.value,"score",null)
                              }
                            }
                          }
                         }
                        }
                      }
                     dynamic"exclude_by_hotword"{
                       for_each = lookup(exclusion_rule.value,"exclude_by_hotword",[])
                       content{
                         dynamic "hotword_regex"{
                          for_each = lookup(exclude_by_hotword.value,"hotword_regex",[])
                          content{
                           pattern = lookup(hotword_regex.value,"pattern",null)
                           group_indexes =lookup(hotword_regex.value,"group_indexes",null)
                          }
                         }            
                         dynamic"proximity"{
                         for_each = lookup(exclude_by_hotword.value,"proximity",[])
                          content{
                            window_before = lookup(proximity.value,"window_before",null)
                            window_after =  lookup(proximity.value,"window_after",null)
                          }
                         }
                        }
                      }
                    }
                  }
                }
               }
              }
            }         
            dynamic "custom_info_types"{
              for_each   = lookup(inspect_config.value,"custom_info_types",[])
              content{
                surrogate_type = lookup(custom_info_types.value.value,"surrogate_type",null)
                likelihood     = lookup(custom_info_types.value,"likelihood",null)
                exclusion_type = lookup(custom_info_types.value,"exclusion_type",null)
                dynamic"info_types"{
                  for_each   = lookup(custom_info_types.value,"info_types",[])
                  content{
                    name    = lookup(info_types.value,"name",null)
                    version = lookup(info_types.value,"version",null)
                  }
                  dynamic"sensitivity_score"{
                   for_each   = lookup(custom_info_types.value,"sensitivity_score",[])
                    content{
                     score = lookup(sensitivity_score.value,"score",null)
                    }
                  }
                }
                dynamic"sensitivity_score"{
                 for_each   = lookup(custom_info_types.value,"sensitivity_score",[])
                 content{
                   score = lookup(sensitivity_score.value,"score",null)
                  }
                }
                dynamic"regex"{
                  for_each   = lookup(custom_info_types.value,"regex",[])
                  content{
                   pattern       = lookup(regex.value," pattern",null)
                   group_indexes = lookup(regex.value," group_indexes",null)
                  }
                }
                dynamic"dictionary"{
                  for_each   = lookup(custom_info_types.value,"dictionary",[])
                  content{
                   dynamic"word_list"{
                   for_each   = lookup(dictionary.value,"word_list",[])
                   content{
                     words = lookup(word_list.value,"words",null)
                    }
                   }
                   dynamic"cloud_storage_path"{
                    for_each   = lookup(dictionary.value,"cloud_storage_path",[])
                    content{
                      path = lookup(cloud_storage_path.value,"path",null)
                    }
                   }
                  }
                }
                dynamic"stored_type"{
                  for_each   = lookup(custom_info_types.value,"stored_type",[])
                  content{
                    name        = lookup(stored_type.value,"name",null)
                    create_time = lookup(stored_type.value,"create_time",null)
                  }
                } 
              }
            }
          }
        }
        storage_config {
         for_each = var.storage_config
         content {
           dynamic "timespan_config"{
           for_each = lookup(storage_config.value,"timespan_config",[])
           content {
             start_time = lookup(timespan_config.value,"start_time",null)
             end_time   = lookup(timespan_config.value,"end_time",null)
             enable_auto_population_of_timespan_config = lookup(timespan_config.value,"enable_auto_population_of_timespan_config",null)
             dynamic "timestamp_field"{
               content {
                  for_each = lookup(timespan_config.value,"timestamp_field",[])
                  name = lookup(timestamp_field.value,"name",null)
                }
              }
            }
           }
           dynamic"datastore_options"{
           for_each = lookup(storage_config.value,"datastore_options",[])
           content {
             dynamic"partition_id"{
            for_each = lookup(datastore_options.value,"partition_id",[])
            content {
             project_id = lookup(partition_id.value,"project_id",null)
             namespace_id = lookup(partition_id.value,"namespace_id",null)
            }
             }
             dynamic"kind"{
               for_each = lookup(datastore_options.value,"kind",[])
               content {
                 name = lookup(kind.value,"name",null)
                }
              }
            }
           }
           dynamic "cloud_storage_options"{
           for_each = lookup(storage_config.value,"cloud_storage_options",[])
           content {
             dynamic "file_set"{
               for_each = lookup(cloud_storage_options.value,"file_set",[])
               content {
                 url= lookup(file_set.value,"url",null)
                 dynamic "regex_file_set"{
                   for_each = lookup(cloud_storage_options.value,"regex_file_set",[])
                   content {
                     bucket_name = lookup(regex_file_set.value,"bucket_name",null)
                     include_regex = lookup(regex_file_set.value,"include_regex",null)
                     exclude_regex = lookup(regex_file_set.value,"exclude_regex",null)
                    }
                  }
                }
              }
             bytes_limit_per_file = lookup(cloud_storage_options.value," bytes_limit_per_file",[])
             bytes_limit_per_file_percent = lookup(cloud_storage_options.value,"bytes_limit_per_file_percent",[])
             files_limit_percen = lookup(cloud_storage_options.value,"files_limit_percen",[])
             file_types         = lookup(cloud_storage_options.value,"file_types",[])
             sample_method      = lookup(cloud_storage_options.value,"sample_method",[])
            }
           }
           dynamic"big_query_options"{
           for_each = lookup(storage_config.value,"big_query_options",[])
           content{
             dynamic "table_reference"{
             for_each = lookup(storage_config.value,"table_reference",[])
             content{
               project_id = lookup(table_reference.value,"project_id",null)
               dataset_id = lookup(table_reference.value,"dataset_id",null)
               table_id   = lookup(table_reference.value,"table_id",null)
              }
             }
             rows_limit         = lookup(big_query_options.value,"rows_limit",null)
             rows_limit_percent = lookup(big_query_options.value,"rows_limit_percent",null)
             sample_method      = lookup(big_query_options.value,"sample_method ",null)
             dynamic"identifying_fields"{
             for_each = lookup(storage_config.value,"identifying_fields",[])
             content{
               name = lookup(identifying_fields.value,"name",null)
              }
             }
             dynamic" included_fields"{
             for_each = lookup(storage_config.value,"included_fields",[])
             content{
               name = lookup(included_fields.value,"name",null)
              }
             }
             dynamic"excluded_fields"{
             for_each = lookup(storage_config.value,"excluded_fields",[])
             content{
               name = lookup(excluded_fields.value,"name",null)
              }
             }
            }
           }
           dynamic"hybrid_options"{
           for_each = lookup(storage_config.value,"hybrid_options",[])
           content {
             description = lookup(hybrid_options.value,"description",null)
             required_finding_label_keys = lookup(hybrid_options.value,"required_finding_label_keys",null)
             labels =  lookup(hybrid_options.value,"labels",null)
             dynamic "table_options"{
              for_each = lookup(hybrid_options.value,"table_options",[])
              content {
               dynamic "identifying_fields"{
                  for_each = lookup(table_options.value,"identifying_fields",[])
                  content{
                    name = lookup(identifying_fields.value,"name",[])
                  }
                }
              }
             }  
            }
           }
          }
        }
        dynamic"actions"{
          for_each = lookup(inspect_job.value,"actions",[])
          content {
           dynamic"save_findings"{
            for_each = lookup(actions.value,"save_findings",[])
            content {
             output_config{
               for_each = var.output_config 
               table {
                 for_each = var.table
                 content{
                   #project_id = lookup(table.value,"project_id",null)
                   #dataset_id = lookup(table.value,"dataset_id",null)
                   #table_id   = lookup(table.value,"table_id",null)
                  }
                }
                 output_schema = var.output_schema
              }
            }
           }
           dynamic "pub_sub"{
            for_each = lookup(actions.value,"pub_sub",[])
            content{
              topic = var.pub_sub
            }
           }
           publish_summary_to_cscc = var.publish_summary_to_cscc[*]
           publish_findings_to_cloud_data_catalog = var.publish_findings_to_cloud_data_catalog[*]
           job_notification_emails = var.job_notification_emails[*]
           dynamic"deidentify"{
            for_each = lookup(actions.value,"deidentify",[])
            content {
              cloud_storage_output = var.cloud_storage_output[*]
              file_types_to_transform = var.file_types_to_transform[*]
              dynamic "transformation_config"{
                for_each = lookup(deidentify.value,"transformation_config",[])
                 content {
                   deidentify_template = lookup(transformation_config.value,"deidentify_template",null)
                   structured_deidentify_template = lookup(transformation_config.value,"structured_deidentify_template",null)
                   image_redact_template = lookup(transformation_config.value,"image_redact_template",null)
                  }
              }
              dynamic "transformation_details_storage_config"{
                for_each = lookup(deidentify.value,"transformation_details_storage_config",[])
                content {
                  table {
                    for_each = var.table[*]
                    content{
                     # table      = lookup(table.value,"table",null)
                     #project_id = lookup(table.value,"project_id",null)
                     table_id   = lookup(table.value,"table_id",null)
                    }
                  }
                }
              }
            }
           }
           publish_to_stackdriver = var.publish_to_stackdriver[*]
          }
        }
      }
    }
}
