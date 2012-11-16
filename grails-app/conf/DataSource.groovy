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
            url = "jdbc:mysql://10.0.0.1/teleh"
            //url = "jdbc:postgresql://10.0.0.3:5432/tages"
            username = "root"
            password = "root"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql://10.0.0.3:5432/mies"
            url = "jdbc:postgresql://127.0.0.1:5432/v"
            username = "postgres"
            //password = "postgres"
            password = "Sunday.server.2011"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/teleh"
            username = "root"
            password = "mies1809"
        }
    }
}
