after 'deploy:finishing_rollback', 'supervisord:service:restart'
after 'deploy:published', 'supervisord:service:restart'
