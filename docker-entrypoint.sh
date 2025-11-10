#!/bin/bash
set -e

# If PHP_MEMORY_LIMIT is defined, drop a custom ini
if [ -n "$PHP_MEMORY_LIMIT" ]; then
  echo "memory_limit = ${PHP_MEMORY_LIMIT}" \
    > /usr/local/etc/php/conf.d/custom_php_memory.ini
  echo "PHP memory_limit set to ${PHP_MEMORY_LIMIT}"
fi

# Finally, exec the original entrypoint (from the php image) with whatever args
exec docker-php-entrypoint "$@"