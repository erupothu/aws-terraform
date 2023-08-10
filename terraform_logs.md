

#### logs

> export TF_LOG = ERROR  
> export TF_LOG_PATH = /tmp/terraform.log  
> terraform apply  
> head 10 /tmp/terraform.log  

#### Taint and untaint
> terraform untaint aws_instance.webserver  (this will not replace the instance)  

#### Import resources

> terraform import <resource_type>.<resource_name> <attribute>  
> terraform import aws_instance.webserver   i-026dealdfajoewirwer  
> 
