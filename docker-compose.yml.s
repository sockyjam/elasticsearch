version: '2'

services:


    es01:
        image: elasticsearch:7.7.0
        container_name: sockyjam.es01
        environment:
            - node.name=es01
            - cluster.name=es-docker-cluster
            - discovery.seed_hosts=es02,es03
            #- discovery.type=single-node
            - cluster.initial_master_nodes=es01,es02,es03
            - bootstrap.memory_lock=true
            - "ES_JAVA_OPTS=-Xms256m -Xmx256m"
        ulimits:
            memlock:
                soft: -1
                hard: -1
        volumes:
            - ./es_data01:/usr/share/elasticsearch/data
        ports:
            - 9200:9200
        networks:
            - elastic


    es02:
        image: elasticsearch:7.7.0
        container_name: sockyjam.es02
        environment:
            - node.name=es02
            - cluster.name=es-docker-cluster
            - discovery.seed_hosts=es01,es03
            #- discovery.type=single-node
            - cluster.initial_master_nodes=es01,es02,es03
            - bootstrap.memory_lock=true
            - "ES_JAVA_OPTS=-Xms256m -Xmx256m"
        ulimits:
            memlock:
                soft: -1
                hard: -1
        volumes:
            - ./es_data02:/usr/share/elasticsearch/data
        networks:
            - elastic



    es03:
        image: elasticsearch:7.7.0
        container_name: sockyjam.es03
        environment:
            - node.name=es03
            - cluster.name=es-docker-cluster
            - discovery.seed_hosts=es01,es02
            #- discovery.type=single-node
            - cluster.initial_master_nodes=es01,es02,es03
            - bootstrap.memory_lock=true
            - "ES_JAVA_OPTS=-Xms256m -Xmx256m"
        ulimits:
            memlock:
                soft: -1
                hard: -1
        volumes:
            - ./es_data03:/usr/share/elasticsearch/data
        networks:
            - elastic


networks:
    elastic:
        driver: bridge
