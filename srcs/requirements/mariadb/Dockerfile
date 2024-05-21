FROM debian:bullseye

# Instalar dependências e MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server vim && \
    apt-get clean

# Criar o diretório para o socket do MariaDB e ajustar permissões
RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld

# Copiar arquivos de configuração e script de inicialização
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/mariadb.sh /usr/local/bin/mariadb.sh

# Tornar o script executável
RUN chmod +x /usr/local/bin/mariadb.sh

# Executar o script de inicialização ao iniciar o contêiner
CMD ["/usr/local/bin/mariadb.sh"]
