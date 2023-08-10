

#### functions

#### Numaric functions

> terraform console  
> max(-1,2,6,9,2,5,6)  
> min(-1,2,6,9,2,5,6)  
> max(var.num..)  
> ceil(10.1)  
> floor(10.6)  

#### String functions
> terraform console  
>   split(":", "haere:this:adfoewri")  
> lower(var.ami)  
> upper(var.ami)  
> title(var.ami)  
> substr(var.ami, 4,10)  
> join(":", "lkafowe:adfa:adfwer)  

#### Collection functions
> length(var.ami)  
> index(var.ami, "ami-abc")  
> element(var.ami,2)  
> contains(var.ami, "ami-abc")  

#### Map function
> terraform console  
> keys(var.ami)  
> values(var.ami)  
> lookup(var.ami, "ami-abc")  
> lookup(var,ami, "avb", "dafaer")  

#### Conditonal operations
> terraform console  
> 8 == 8  
> 8 != 8  
> 8 <= 8  
> 9 > 7 && 7 < 20  

> condition ? true_value : false_value  
> length = var.length < 8 ?  : var.length  
