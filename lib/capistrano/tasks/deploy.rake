after 'deploy:finishing_rollback', 'supervisord:service:restart'
after 'deploy:updated', 'supervisord:service:restart'
