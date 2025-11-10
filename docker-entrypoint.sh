#!/bin/bash
set -e

# Path for our custom overrides (late alphabet => higher precedence)
CUSTOM_INI="/usr/local/etc/php/conf.d/zzz-custom.ini"

# Build the ini contents
{
  # Always disable display_errors in production to prevent sensitive error details from being exposed to users.
  echo "display_errors = Off"

  # Optionally set memory_limit if provided
  if [ -n "$PHP_MEMORY_LIMIT" ]; then
    echo "memory_limit = ${PHP_MEMORY_LIMIT}"
  fi
} > "$CUSTOM_INI"

# Finally, exec the original entrypoint (from the php image) with whatever args
exec docker-php-entrypoint "$@"
