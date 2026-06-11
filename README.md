# Public images & run script

This repository includes GitHub Actions workflows to build and publish Docker images to GitHub Container Registry (GHCR) and to deploy the frontend to GitHub Pages.

Workflows added:
- .github/workflows/publish-images.yml — builds backend and frontend images and pushes them to ghcr.io/${{ github.repository_owner }}
- .github/workflows/deploy-pages.yml — builds the frontend and deploys the dist/ site to GitHub Pages

How to use

1) Build & publish images (via Actions):
   - Go to Actions → "Build and publish Docker images" → Run workflow (or push to main)
   - Images will be available at:
     - ghcr.io/estebanguzman2305-byte/mi-asistente-ia-backend:latest
     - ghcr.io/estebanguzman2305-byte/mi-asistente-ia-frontend:latest

2) Run locally using the published images (or build locally):
   - Make sure you have the environment variables exported in your shell (OPENAI_API_KEY, ANTHROPIC_API_KEY, PINECONE_API_KEY, PINECONE_ENV, JWT_SECRET).
   - Run the helper script:
     chmod +x run.sh
     ./run.sh

3) Deploy frontend to GitHub Pages:
   - Go to Actions → "Deploy Frontend to GitHub Pages" → Run workflow (or push to main)
   - Enable Pages in repository Settings if required.

Notes
- The GHCR publishing uses the default GITHUB_TOKEN provided to Actions (no extra secret required). If you prefer to use a PAT for GHCR, create a secret and update the workflow.
- The run.sh script expects the images to exist in GHCR or locally. If you haven't published images yet you can build them locally with docker build.
