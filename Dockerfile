FROM python:3.12-alpine3.19
LABEL maintainer="Aditya Godambe"

ENV PYTHONUNBUFFERED=1

COPY ./requirments.txt /tmp/requirments.txt
COPY ./requirments.dev.txt /tmp/requirments.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirments.txt && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirments.dev.txt; fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
