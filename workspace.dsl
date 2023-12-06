workspace "council" "data store" {

    model {

        properties {
            "structurizr.groupSeparator" "/"
        }

        notebook = softwareSystem "TRE Design Notebook" {
            !docs docs
            !adrs adrs
        }

        group "council services" {
            lbthProcessor = person "lbth processor" "data processor"
            lbthController = person "lbth controller" "data controller"
            service = softwareSystem "service(s)" "stores service records" "datastore" {
                service_container = container "R.A.P" "address-to-UPRN matching" "API" "pipeline" {
                    assign_image = component "Address matching" "Address matching API" "API" "pipeline"
                }
            }
            catalogue = softwareSystem "catalogue" "catalogues research metadata" "datastore" {
                catalogue_container = container "metadata store" "metadata" "metadata" "datastore" {
                    ncmp_image = component "ncmp" "child measurement programme" "metadata" "datastore"
                    gp_utilisation_image = component "gp utilisation" "data asset" "metadata" "datastore"
                    school_attendance_image = component "school attendance" "data asset" "metadata" "datastore"
                    school_attainment_image = component "school attainment" "data asset" "metadata" "datastore"
                }
            }
            tre = softwareSystem "trusted research environment" "controlled environment for reproducible analytical pipelines" "pipeline" {
                tre_container = container "R.A.P" "Reproducible Analytical Pipeline" "Automation system" "pipeline" {
                    tre_image = component "Data linking" "Reproducible Analytical Pipeline" "python" "pipeline"
                }
            }
        }

        group "keyholder" {
            keyProcessor = person "key holder" "generates and rescinds keys"
        }

        group "qmul" {
            qmulProcessor = person "qmul processor" "data processor"
            gpData = softwareSystem "gpData" "stores health records" "datastore" {
                gp_container = container "R.A.P" "address-to-UPRN matching" "API" "pipeline" {
                    assign_image_gp = component "Address matching" "Address matching API" "API" "pipeline"
                }
            }
        }

        group "gps" {
            gpController = person "gp(s)" "data controller"
        }

        group "household" {
            resident = person "resident(s)" "data subject(s)" "resident"
        }
    
        lbthController -> service "controls"
        gpController -> gpData "controls"

        resident -> service "writes"
        resident -> gpData "writes"

        service -> catalogue "metadata"
        gpData -> catalogue "metadata"

        lbthProcessor -> lbthController "requests data"
        qmulProcessor -> lbthController "agrees access"
        lbthController -> keyProcessor "requests encryption key"
        keyProcessor -> catalogue "manages encryption keys" { 
            tags "in development" 
        } 

        lbthProcessor -> catalogue "finds"
        qmulProcessor -> catalogue "finds"
        
        service -> tre "encrypted data"
        gpData -> tre "encrypted data"

        lbthProcessor -> tre "accesses"
        qmulProcessor -> tre "accesses"  

        lbthProcessor -> resident "communicates"
        qmulProcessor -> resident "communicates"  

    }

    views {

        dynamic * "dynamic" {
            title "Research data management"
            { 
                { 
                    lbthController -> service "controls" 
                }
                { 
                    gpController -> gpData "controls" 
                }
            }
            {
                {
                    resident -> service "writes"
                }
                {
                    resident -> gpData "writes"
                }
            }

            {            
                {
                    service -> catalogue "metadata"
                }
                {
                    gpData -> catalogue "metadata"
                }
            }
            {
                {
                    lbthProcessor -> catalogue "finds data"
                }
                {
                    qmulProcessor -> catalogue "finds data"
                }
            }
            {
                {
                    lbthProcessor -> lbthController "requests data"
                }
                {
                    qmulProcessor -> lbthController "agrees access"
                }
                {
                    lbthController -> keyProcessor "requests encryption key"
                }
                {
                    keyProcessor -> catalogue "manages encryption keys"
                }
            }
            { 
                {
                    service -> tre "encrypted data"
                }
                {
                    gpData -> tre "encrypted data"
                }
                {
                    lbthProcessor -> tre "reproducible analytical pipeline"
                }
                {
                    qmulProcessor -> tre "reproducible analytical pipeline"
                }
            }
            description "dynamic view showing the standard operating procedure of events, connections, and approvals required to manage research data from listing to reporting via analysing."
            autoLayout
        }
        
        systemlandscape "systemlandscape" "systemlandscape" {
            include * 
            exclude notebook
            description "system landscape view of the working parts in this design, people, (meta)data, processes, and networks" 
            autoLayout
        }

        systemContext "catalogue" "catalogue" {
            include *
            description "context view of the metadata catalogue and the containers within" 
            autoLayout
        }

        container "catalogue" "catalogue_container" {
            include *
            description "container view of the metadata catalogue and the components within" 
            autoLayout
        }

        component "catalogue_container" "catalogue_component" {
            include *
            description "component view of the metadata catalogue and the <del>code</del>data within" 
            autoLayout
        }

        image ncmp_image "ncmp_image" {
            image https://kroki.io/erd/svg/eNqLDigtyMyJ5dLKTOHKS8xN5eKKdiwpSczMy03NK4nl0i4ASccDJYtLk7JSk0u4lBKLi1OLi0HSClAxJRTBlMSSVFSR9KLEFKAQF9gqBUNdXS0FhB0AaH4sqg==
        }
        image gp_utilisation_image "gp_utilisation_image" {
            image https://kroki.io/erd/svg/eNqLDkgsyUzNK4nl0spLzE3lykjNTM8o4SqHUNrpBVxc0UGp6ZnFJUVAhfl5QHWZKVzFJYlFJVypeSlcIAVQIxS0dHUNFZAVAwDO1B9_
        }
        image school_attendance_image "school_attendance_image" {
            image https://kroki.io/erd/svg/eNqLDigtyMyJ5dLKTOHKS8xN5eKKDkpNzywuSS2K5dIuAEnGA6USS0pS81JSU7iUilITi_PzFNLyixQSk4pT85JTlbjAZiho6eoaKsA0AwAy1h3a
        }
        image school_attainment_image "school_attainment_image" {
            image https://kroki.io/erd/svg/eNqL9nP2DYjlSkxJKUotLuZS0tPTU-LiinaE8J0Si1MDilJzM0tzY7lKC4ryuHLy0rlyEku4knMSi4sz0zKTE0sy8_PiS1KLcmGaQSYqGOrqGipgmgIA0BAkIw==
        }

        systemContext "tre" "tre" {
            include * 
            description "context view of the trusted research environment and the containers within" 
            autoLayout
        }

        container "tre" "tre_container" {
            include *
            description "container view of the trusted research environment and the components within" 
            autoLayout
        }

        component "tre_container" "tre_component" {
            include *
            description "container view of the trusted research environment and the <del>code</del>data within" 
            autoLayout
        }

        systemContext "service" "service" {
            include *
            description "context view of service datasets and the containers within" 
            autoLayout
        }

        container "service" "service_container" {
            include *
            description "container view of the service datasets and the components within" 
            autoLayout
        }

        component "service_container" "service_component" {
            include *
            description "component view of the service datasets and the <del>code</del>data within" 
            autoLayout
        }

        image tre_image "tre_image" {
            image https://kroki.io/actdiag/svg/eNpNjksOwjAMRPc9hZUVLHoCBBcBFqZxg9XEQWmKhFDvTj4N6i7OzLwZHKJmNPDtAFheS4T-AoOXN4XyZIeGuiRaFIJlplCs-X6QhTOoklLlrwKuf0lTz5ok8sikQWNEuAnMTwyUOpzzAhN91P1U07lql7Ys0xarlrXNUAWVdRajtkFt9K6-uTI3FY-LDJG9HOZjA64_HuxQBg==
        }

        image assign_image "assign_image" {
            image https://kroki.io/actdiag/svg/eNpLTC5JyUxMV6jmUlDIzCsoLVHQtVNIzs8rSy0CMzNzE9NTuYCSOYl5qQqlxalFYKUgflJqjoKtgpInSJcSWAxiQDRcyjElpSi1uDi1WCnWGqIAZBo2BQraCjF5oQFBfkCGk09AKERDLcxeJcfgYE93PwXHAE8lqP0wNyIMc4aKQA1VKMnHbmYtAPHJR_w=
        }

        image assign_image_gp "assign_image_gp" {
            image https://kroki.io/actdiag/svg/eNpLTC5JyUxMV6jmUlDIzCsoLVHQtVNIzs8rSy0CMzNzE9NTuYCSOYl5qQqlxalFYKUgflJqjoKtgpInSJcSWAxiQDRcyjElpSi1uDi1WCnWGqIAZBo2BQraCjF5oQFBfkCGk09AKERDLcxeJcfgYE93PwXHAE8lqP0wNyIMc4aKQA1VKMnHbmYtAPHJR_w=
        }

        dynamic * "linkedanalysis" {
            title "linked analysis"
            {
                {
                    lbthProcessor -> tre "links datasets"
                    qmulProcessor -> tre "links datasets"  
                }
            }
            description "dynamic view of the system elements involved in data linkages"
            autoLayout
        }

        dynamic * "statisticaldisclosurecontrol" {
            title "Statistical disclosure control"
            {
                {
                    lbthProcessor -> tre "prevent disclosure"
                    qmulProcessor -> tre "prevent disclosure"  
                }
            }
            description "ensure aggregated data is not disclosive"
            autoLayout
        }

        dynamic * "output" {
            title "output"
            {
                {
                    lbthProcessor -> resident "communicates"
                    qmulProcessor -> resident "communicates"  
                }
            }
            description "dynamic view of the key elements involved in disseminating aggregated data and reseach findings"
            autoLayout
        }

        theme default
        styles {
            element "Element" {
                fontSize 14
            }
            element "resident" {
                background seagreen
                color  white
                shape Person
            }
            element "pipeline" {
                shape Pipe
            }
            element "app" {
                shape WebBrowser
            }
            element "datastore" {
                shape Cylinder
            }

            relationship "Relationship" {
                color black
                fontSize 44
            }
            relationship "in development" {
                colour green
            }
        }
    }
}
