FROM python:3-slim AS builder
ADD . /app
WORKDIR /app

# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app requests click

# A distroless container image with Python and some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/python3-debian10
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["echo 'wht is this'"]
# CMD ["main.py  --region $INPUT_CONFORMITY_REGION --api_key $INPUT_CONFORMITY_API_KEY --template_type $INPUT_TEMPLATE_TYPE --template_path $INPUT_TEMPLATE_PATH " ]