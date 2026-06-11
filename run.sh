#!/usr/bin/env bash
set -e

# Run the Asistente IA using images published to GHCR
# Requires that you have pulled or built the images and have the following env vars set:
# OPENAI_API_KEY, ANTHROPIC_API_KEY, PINECONE_API_KEY, PINECONE_ENV, JWT_SECRET

BACKEND_IMG="ghcr.io/estebanguzman2305-byte/mi-asistente-ia-backend:latest"
FRONTEND_IMG="ghcr.io/estebanguzman2305-byte/mi-asistente-ia-frontend:latest"

echo "Creating docker network 'asistente-net'..."
docker network create asistente-net || true

echo "Starting Redis..."
docker run -d --name asistente-redis --network asistente-net -p 6379:6379 redis:7

echo "Starting backend container..."
docker run -d --name asistente-backend --network asistente-net -p 8000:8000 \
  -e REDIS_URL=redis://asistente-redis:6379/0 \
  -e OPENAI_API_KEY="${OPENAI_API_KEY}" \
  -e ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}" \
  -e PINECONE_API_KEY="${PINECONE_API_KEY}" \
  -e PINECONE_ENV="${PINECONE_ENV}" \
  -e JWT_SECRET="${JWT_SECRET}" \
  "${BACKEND_IMG}"

echo "Starting frontend container..."
docker run -d --name asistente-frontend --network asistente-net -p 3000:80 \
  -e VITE_API_BASE_URL=http://localhost:8000/api \
  "${FRONTEND_IMG}"

echo "All services started."
echo "Backend: http://localhost:8000"
echo "Frontend: http://localhost:3000"
