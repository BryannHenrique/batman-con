dataSource {
	pooled = true
	dbCreate = "update" // one of 'create', 'create-drop','update'
	url = "jdbc:mysql://localhost/springbatch"
	driverClassName = "com.mysql.jdbc.Driver"
	username = "root"
	password = ""	
}

hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
}
// environment specific settings
environments {
	production {
		dataSource {
		    jndiName = "java:comp/env/springbatchjdbc"
		}	
	}
	
}