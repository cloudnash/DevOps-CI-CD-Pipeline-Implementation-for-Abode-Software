FROM hshar/webapp
LABEL description="Abode Software Web Application"

WORKDIR /var/www/html

COPY . /var/www/html/

RUN chmod -R 755 /var/www/html

RUN mkdir -p /tests
COPY tests/ /tests/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1

CMD ["apache2ctl", "-D", "FOREGROUND"]
