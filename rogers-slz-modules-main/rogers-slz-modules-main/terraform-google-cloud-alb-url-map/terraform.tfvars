
        url_map_name                                                        = "gcp-yyz-dev-tsi-crun-test-http-alb-01"
		scope																= "global"
		project_id                          								= "gcp-prj-inf-networkhub-prd-1"
		region							    								= "northamerica-northeast2"
		backend_service_id													= ""			
        url_map_description                 								= "URL MAP for External Global HTTP LB"
		
		header_action														= [
			{
				request_headers_to_add      								= [
					{								
						header_name         								= "AddMe"
						header_value        								= "MyValue"
						replace             								= true
					}								
				]								
				request_headers_to_remove   								= ["RemoveMe"]
				response_headers_to_add     								= [
					{								
						header_name         								= "AddMe"
						header_value        								= "MyValue"
						replace             								= false
					}								
				]								
				response_headers_to_remove  								= ["RemoveMe"]
			}
		]

		host_rule															= [
			{								
				description                 								= ""
				hosts                       								= ["*"]
				path_matcher                								= "allpaths"
			}								
		]								
		path_matcher														= [
			{	
				default_service												= ""							
				description                 								= "xyz"
				header_action												= [
					{
						request_headers_to_add      						= [
							{								
								header_name         						= "AddMe"
								header_value        						= "MyValue"
								replace             						= true
							}								
						]								
						request_headers_to_remove   						= ["RemoveMe"]
						response_headers_to_add     						= [
							{								
								header_name         						= "AddMe"
								header_value        						= "MyValue"
								replace             						= false
							}								
						]								
						response_headers_to_remove  						= ["RemoveMe"]

					}
				]

				name                                						= "allpaths"
				route_rules                         						= [
					{
						priority                          					= 1
						service                           					= null
						header_action					   				    = [
							{								
								request_headers_to_add      				= [
									{								
										header_name         				= "AddMe"
										header_value        				= "MyValue"
										replace             				= true
									}								
								]								
								request_headers_to_remove   				= ["RemoveMe"]
								response_headers_to_add     				= [
									{								
										header_name         				= "AddMe"
										header_value        				= "MyValue"
										replace             				= false
									}								
								]								
								response_headers_to_remove  				= ["RemoveMe"]
							}								
						]
						match_rules                       					= [
							{
								full_path_match                 			= "a full path"
								header_matches								= [
									{
										exact_match                   		= "match this exactly"
										header_name                   		= "someheader"
										invert_match                  		= false
										prefix_match                  		= "/"
										present_match                 		= false
										range_match							= [
											/* {
												range_end                   = ""
												range_start                 = ""
											} */
										]
										regex_match                   		= null
										suffix_match                  		= null
									}
								]
								ignore_case                     			= false
								metadata_filters                			= [
									{
										filter_labels                 		= [
											{
												name                        = "PLANET"
												value                       = "MARS"
											}
										]
										filter_match_criteria         		= "MATCH_ANY"
									}
								]
								prefix_match                    			= "/"
								query_parameter_matches         			= [
									{
										exact_match                   		= "b"
										name                          		= "a query parameter"
										present_match                 		= false
										regex_match                   		= null
									}
								]
								regex_match                     			= null
								path_template_match             			= "/xyzwebservices/v2/xyz/users/{username=*}/carts/{cartid=**}"
							}
						]
						route_action										= [
							{
								cors_policy									= [
									{
										allow_credentials             		= true
										allow_headers                 		= ["Allowed content"]
										allow_methods                 		= ["GET"]
										allow_origin_regexes          		= ["abc.*"]
										allow_origins                 		= ["Allowed origin"]
										disabled                      		= false
										expose_headers                		= ["Exposed header"]
										max_age                       		= 30
									}
								]
								fault_injection_policy          	  		= [
									{
										abort								= [
											{
												http_status             	= 234
												percentage              	= 5.6
											}
										]
										delay                           	= [
											{
												fixed_delay             	= [
													{
														nanos           	= 0
														seconds         	= 50000
													}
												]
												percentage              	= 7.8
											}
										]
									}
								]
								request_mirror_policy           			= [
									{
										backend_service               		= ""
									}
								]
								retry_policy                    			= [
									{
										num_retries                   		= 4
										per_try_timeout               		= [
											{
												nanos                   	= 0
												seconds                 	= 30
											}
										]
										retry_conditions              		= ["5xx", "deadline-exceeded"]	
									}
								]
								timeout                         			= [
									{
										nanos                         		= 750000000
										seconds                       		= 20
									}
								]
								url_rewrite                     			= [
									{
										host_rewrite                  		= "dev.example.com"
										path_prefix_rewrite           		= "/v1/api/"
										path_template_rewrite				= null
									}
								]
								weighted_backend_services       			= [
									/* {
										backend_service               		= null
										header_action					    = [
											{								
												request_headers_to_add      = [
													{								
														header_name         = "AddMe"
														header_value        = "MyValue"
														replace             = true
													}								
												]								
												request_headers_to_remove   = ["RemoveMe"]
												response_headers_to_add     = [
													{								
														header_name         = "AddMe"
														header_value        = "MyValue"
														replace             = false
													}								
												]								
												response_headers_to_remove  = ["RemoveMe"]
											}								
										]
										weight                              = 400
									} */
								]  
							}
						]
						url_redirect                      					= [
							{
								host_redirect                   			= "A host"
								https_redirect                  			= false
								path_redirect                   			= "some/path"
								prefix_redirect                 			= ""
								redirect_response_code          			= "TEMPORARY_REDIRECT"
								strip_query                     			= true
							}
						]
					}
				]

				path_rule													= [
					{						
						service                     						= ""
						paths                       						= ["/home"]
						route_action										= [
							{						
								cors_policy									= [
									{
										allow_credentials             		= true
										allow_headers                 		= ["Allowed content"]
										allow_methods                 		= ["GET"]
										allow_origin_regexes          		= ["abc.*"]
										allow_origins                 		= ["Allowed origin"]
										disabled                      		= false
										expose_headers                		= ["Exposed header"]
										max_age                       		= 30
									}
								]
								fault_injection_policy          	  		= [
									{	
										abort								= [
											{	
												http_status             	= 234
												percentage              	= 5.6
											}	
										]	
										delay                           	= [
											{	
												fixed_delay             	= [
													{	
														nanos           	= 0
														seconds         	= 50000
													}	
												]	
												percentage              	= 7.8
											}
										]
									}
								]
								request_mirror_policy           			= [
									{
										backend_service               		= ""
									}
								]
								retry_policy                    			= [
									{
										num_retries                   		= 4
										per_try_timeout               		= [
											{
												nanos                   	= 0
												seconds                 	= 50000
											}
										]
										retry_conditions              		= ["5xx", "deadline-exceeded"]	
									}
								]
								timeout                         			= [
									{
										nanos                         		= 750000000
										seconds                       		= 20
									}
								]
								url_rewrite                     			= [
									{
										host_rewrite                  		= "dev.example.com"
										path_prefix_rewrite           		= "/v1/api/"
										path_template_rewrite				= null
									}
								]
								weighted_backend_services       			= [
									/* {
										backend_service               		= null
										header_action					    = [
											{								
												request_headers_to_add      = [
													{								
														header_name         = "AddMe"
														header_value        = "MyValue"
														replace             = true
													}								
												]								
												request_headers_to_remove   = ["RemoveMe"]
												response_headers_to_add     = [
													{								
														header_name         = "AddMe"
														header_value        = "MyValue"
														replace             = false
													}								
												]								
												response_headers_to_remove  = ["RemoveMe"]
											}								
										]
										weight                              = 400
									} */
								]  
							}
						]
						url_redirect                      					= [
							{
								host_redirect                   			= "A host"
								https_redirect                  			= false
								path_redirect                   			= "some/path"
								prefix_redirect                 			= ""
								redirect_response_code          			= "TEMPORARY_REDIRECT"
								strip_query                     			= true
							}
						]
					}
				]
				
				default_url_redirect                						= [
					/* {
						host_redirect                     					= "A host"
						https_redirect                    					= false
						path_redirect                     					= "some/path"
						prefix_redirect                   					= ""
						redirect_response_code            					= "TEMPORARY_REDIRECT"
						strip_query                       					= true
					} */
				]

				default_route_action									    = [
				/* {
						weighted_backend_services       					= [
							{				
								backend_service               				= null
								header_action					   			= [
									{								
										request_headers_to_add      		= [
											{								
												header_name         		= "AddMe"
												header_value        		= "MyValue"
												replace             		= true
											}								
										]								
										request_headers_to_remove   		= ["RemoveMe"]
										response_headers_to_add     		= [
											{								
												header_name         		= "AddMe"
												header_value        		= "MyValue"
												replace             		= false
											}								
										]								
										response_headers_to_remove  		= ["RemoveMe"]
									}								
								]		
								weight                              		= 400
							}		
						]		
						url_rewrite                     					= [
							{				
								host_rewrite                  				= "dev.example.com"
								path_prefix_rewrite           				= "/v1/api/"
								path_template_rewrite						= null
							}				
						]			
						timeout                         					= [
							{				
								nanos                         				= 0
								seconds                       				= 30
							}				
						]		
						retry_policy                    					= [
							{				
								num_retries                   				= 4
								per_try_timeout               				= [
									{				
										nanos                   			= 0
										seconds                 			= 30
									}				
								]				
								retry_conditions              				= ["5xx", "deadline-exceeded"]	
						}
					]
						request_mirror_policy           					= [
							{				
								backend_service               				= ""
							}				
						]		
						cors_policy											= [
							{		
								allow_credentials             				= true
								allow_headers                 				= ["Allowed content"]
								allow_methods                 				= ["GET"]
								allow_origin_regexes          				= ["abc.*"]
								allow_origins                 				= ["Allowed origin"]
								disabled                      				= false
								expose_headers                				= ["Exposed header"]
								max_age                       				= 30
							}		
						]		
						fault_injection_policy          	  				= [
							{				
								abort										= [
									{				
										http_status             			= 234
										percentage              			= 5.6
									}				
								]				
								delay                           			= [
									{				
										fixed_delay             			= [
											{				
												nanos           			= 0
												seconds         			= 50000
											}				
										]				
										percentage              			= 7.8
								}
								]
							}
						]
					} */
				]
			}
		]

		test																= [
			{
				description                         						= "xyz"
				host                                						= "example.com"
				path                                						= "/home"
				service               										= ""
			}
		]
		default_url_redirect                								= [
			/* {
				host_redirect                     							= "A host"
				https_redirect                    							= false
				path_redirect                     							= "some/path"
				prefix_redirect                   							= ""
				redirect_response_code            							= "TEMPORARY_REDIRECT"
				strip_query                       							= true
			} */
		]
		default_route_action									    		= [
			/* {
				weighted_backend_services       							= [
					{				
						backend_service               						= null
						header_action					   				    = [
							{								
								request_headers_to_add      				= [
									{								
										header_name         				= "AddMe"
										header_value        				= "MyValue"
										replace             				= true
									}								
								]								
								request_headers_to_remove   				= ["RemoveMe"]
								response_headers_to_add     				= [
									{								
										header_name         				= "AddMe"
										header_value        				= "MyValue"
										replace             				= false
									}								
								]								
								response_headers_to_remove  				= ["RemoveMe"]
							}								
						]		
						weight                              				= 400
					}		
				]		
				url_rewrite                     							= [
					{				
						host_rewrite                  						= "dev.example.com"
						path_prefix_rewrite           						= "/v1/api/"
						path_template_rewrite								= null
					}				
				]			
				timeout                         							= [
					{				
						nanos                         						= 0
						seconds                       						= 30
					}				
				]		
				retry_policy                    							= [
					{				
						num_retries                   						= 4
						per_try_timeout               						= [
							{				
								nanos                   					= 0
								seconds                 					= 30
							}				
						]				
						retry_conditions              						= ["5xx", "deadline-exceeded"]	
					}
				]
				request_mirror_policy           							= [
					{				
						backend_service               						= ""
					}				
				]		
				cors_policy													= [
					{		
						allow_credentials             						= true
						allow_headers                 						= ["Allowed content"]
						allow_methods                 						= ["GET"]
						allow_origin_regexes          						= ["abc.*"]
						allow_origins                 						= ["Allowed origin"]
						disabled                      						= false
						expose_headers                						= ["Exposed header"]
						max_age                       						= 30
					}		
				]		
				fault_injection_policy          	  						= [
					{				
						abort												= [
							{				
								http_status             					= 234
								percentage              					= 5.6
							}				
						]				
						delay                           					= [
							{				
								fixed_delay             					= [
									{				
										nanos           					= 0
										seconds         					= 50000
									}				
								]				
								percentage              					= 7.8
							}
						]
					}
				]
			} */
		]
		url_map_project_id													= "gcp-prj-inf-networkhub-prd-1"