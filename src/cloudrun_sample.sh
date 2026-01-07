#!/bin/sh
# Enable Cloud Run API
gcloud services enable run.googleapis.com

# Set compute region
gcloud config set compute/region "REGION"

# Create a LOCATION environment variable
LOCATION="Region"

# Build container image using Cloud Build
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

# List all container images
gcloud container images list

# Register gcloud as credential helper for all Google-supported Docker registries
gcloud auth configure-docker

# Run and test application locally
docker run -d -p 8080:8080 gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

# Deploy containerized application to Cloud Run
gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld --allow-unauthenticated --region=$LOCATION

## Clean up
# gcloud container images delete gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
# gcloud run services delete helloworld --region="REGION"
