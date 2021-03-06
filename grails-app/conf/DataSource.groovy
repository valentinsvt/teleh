dataSource {
    pooled = true
    //driverClassName = "org.postgresql.Driver"
    //dialect = org.hibernate.dialect.PostgreSQLDialect
    driverClassName = "com.mysql.jdbc.Driver"
    dialect =  "org.hibernate.dialect.MySQL5InnoDBDialect"
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    //cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://10.0.0.1/cnh"
            //url = "jdbc:mysql://10.0.0.1/infa"
            username = "root"
            password = "root"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://10.0.0.3/teleh"
            username = "root"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://127.0.0.1/cnh"
            username = "root"
            password = "cnhRoot"
        }
    }
}
